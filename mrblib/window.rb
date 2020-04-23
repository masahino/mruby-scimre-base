# coding: utf-8
module Mrbmacs
  class EditWindow
    attr_accessor :sci, :modeline, :frame
    attr_accessor :command_list
    attr_accessor :buffer
    attr_accessor :x1, :y1, :x2, :y2, :width, :height
    def initialize(frame, buffer, x1, y1, width, height)
      $stderr.puts "not yet implemented"
    end

    def set_buffer(buffer)
      @sci.sci_set_docpointer(buffer.docpointer)
      @sci.sci_set_lexer_language(buffer.mode.name)
#      buffer.mode.set_style(view_win, @theme)
    end

    def compute_area
    end

    def refresh
    end

    def focus_in()
      @sci.sci_set_focus(true)
      @sci.sci.refresh
    end

    def focus_out()
      @sci.sci_set_focus(false)
      @sci.sci.refresh
    end

    def set_default_style(theme)
      @sci.sci_style_set_fore(Scintilla::STYLE_DEFAULT, theme.foreground_color)
      @sci.sci_style_set_back(Scintilla::STYLE_DEFAULT, theme.background_color)
      @sci.sci_style_clear_all
      if theme.font_color[:color_brace_highlight]
        @sci.sci_style_set_fore(Scintilla::STYLE_BRACELIGHT,
          theme.font_color[:color_brace_highlight][0])
        @sci.sci_style_set_back(Scintilla::STYLE_BRACELIGHT,
          theme.font_color[:color_brace_highlight][1])
      end
      if theme.font_color[:color_annotation]
        @sci.sci_style_set_fore(254, theme.font_color[:color_annotation][0])
        @sci.sci_style_set_back(254, theme.font_color[:color_annotation][1])
        @sci.sci_annotation_set_visible(Scintilla::ANNOTATION_BOXED)
      end
      @sci.sci_set_property("fold", "1")
      @sci.sci_set_wrap_mode(Scintilla::SC_WRAP_CHAR)
    end

  end

  class Application
    def other_window
      if @frame.edit_win_list.size > 1
        index = @frame.edit_win_list.index(@frame.edit_win) + 1
        if index >= @frame.edit_win_list.size
          index = 0
        end
        @frame.switch_window(@frame.edit_win_list[index])
#      @frame.switch_window(@frame.edit_win_list.rotate!().first)
        @current_buffer = @frame.edit_win.buffer
      end
    end

    def delete_window
      active_win = @frame.edit_win
      if @frame.edit_win_list.size ==1
        @frame.echo_puts("Atempt to delete sole ordinary window")
        return
      end
      x1 = active_win.x1
      x2 = active_win.x2
      y1 = active_win.y1
      y2 = active_win.y2
      new_win = nil
      count = 0
      expand_wins = Hash.new()
      expand_wins[:left] = []
      expand_wins[:right] = []
      expand_wins[:top] = []
      expand_wins[:bottom] = []

      @frame.edit_win_list.each do |e|
        if e == active_win
          next
        end
        new_win = e
        ex1 = e.x1
        ex2 = e.x2
        ey1 = e.y1
        ey2 = e.y2

        if x1 == ex2 && y1 == ey1 && y2 == ey2
          # left border
          e.x2 = x2
          count += 1
          break
        elsif x2 == ex1 && y1 == ey1 && y2 == ey2
          # right border
          e.x1 = x1
          count += 1
          break
        elsif y1 == ey2 && x1 == ex1 && x2 == ex2
          #  top border
          e.y2 = y2
          count += 1
          break
        elsif y2 == ey1 && x1 == ex1 && x2 == ex2
          # bottom border
          e.y1 = y1
          count += 1
          break
        elsif x1 == ex2
          expand_wins[:left].push e
        elsif x2 == ex1
          expand_wins[:right].push e
        elsif y1 == ey2
          expand_wins[:top].push e
        elsif y2 == ey1
          expand_wins[:bottom].push e
        end
      end
      if count == 0
        if expand_wins[:left].size > 1
          count = expand_wins[:left].size
          expand_wins[:left].each do |w|
            w.x2 = x2
            w.compute_area
          end
          new_win = expand_wins[:left].first
        elsif expand_wins[:right].size > 1
          count = expand_wins[:right].size
          expand_wins[:right].each do |w|
            w.x1 = x1
            w.compute_area
          end
          new_win = expand_wins[:right].first
        elsif expand_wins[:top].size > 1
          count = expand_wins[:top].size
          expand_wins[:top].each do |w|
            w.y2 = y2
            w.compute_area
          end
          new_win = expand_wins[:top].first
        elsif expand_wins[:bottom].size > 1
          count = expand_wins[:bottom].size
          expand_wins[:bottom].each do |w|
            w.y1 = y1
            w.compute_area
          end
          new_win = expand_wins[:bottom].first
        end
      end
      if count > 0
        new_win.compute_area
        @frame.switch_window(new_win)
        active_win.delete
        @frame.edit_win_list.delete(active_win)
        @frame.edit_win_list.each do |w|
          w.refresh
        end
      else
        $stderr.puts "can't find any window"
      end
    end

    def delete_other_window
      @frame.delete_other_window
    end

    def split_window(horizon)
      active_win = @frame.edit_win
      if horizon == true
        x = ((active_win.x2 + active_win.x1) / 2).to_i
        y = active_win.y1
        width = active_win.x2 - x
        height = active_win.y2 - active_win.y1
        if width < 10
          @frame.echo_puts("too small for splitting")
          return
        end
        active_win.x2 = x
      else
        y = ((active_win.y2 + active_win.y1) / 2).to_i
        x = active_win.x1
        width = active_win.x2 - active_win.x1
        height = active_win.y2 - y
        if height < 3
          @frame.echo_puts("too small for splitting")
          return
        end
        active_win.y2 = y
      end

      active_win.compute_area
      active_win.refresh
      new_win = EditWindow.new(@frame, @current_buffer, x, y, width, height)
      @keymap.set_keymap(new_win.sci)
      new_win.set_default_style(@theme)
      @current_buffer.mode.set_style(new_win.sci, @theme)
      @frame.edit_win_list.push(new_win)
      @frame.edit_win_list.each do |win|
        win.refresh()
      end
      @frame.modeline(self, new_win.modeline)
      new_win.focus_out
    end

    def split_window_vertically
      split_window(false)
    end

    def split_window_horizontally
      split_window(true)
    end
  end
end
