# coding: utf-8
module Mrbmacs
  class EditWindow
    attr_accessor :sci, :modeline, :frame
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
    end

  end

  class Application
    def other_window
      @frame.switch_window(@frame.edit_win_list.rotate!().first)
    end

    def delete_window
      $stderr.puts "delete window"
    end

    def delete_other_window
      $stderr.puts "delete other window"
    end

    def split_window_vertically
      active_win = @frame.edit_win
      y = (active_win.y2 + active_win.y1) / 2
      x = active_win.x1
      width = active_win.x2 - active_win.x1
      height = active_win.y2 - y
      if height < 3
        @frame.echo_puts("too small for splitting")
        return
      end
      active_win.y2 = y;
      active_win.compute_area
      active_win.refresh
      new_win = EditWindow.new(@frame, @current_buffer, x, y, width, height)
#      new_win = EditWindow.new(@frame, Buffer.new(), x, y, width, height)
      @keymap.set_keymap(new_win.sci)
    new_win.set_default_style(@theme)
#      @current_buffer.mode.set_style(new_win.sci, @theme)
      @frame.edit_win_list.push(new_win)
      @frame.edit_win_list.each do |win|
        win.refresh()
      end
      @frame.modeline(self, new_win.modeline)
      new_win.focus_out
#      e = edit_new(s->b, s->x1, y,
#                     s->x2 - s->x1, s->y2 - y,
#                     WF_MODELINE | (s->flags & WF_RSEPARATOR));
    end

    def split_window_horizontally
      $stderr.puts "split window horizontally"
    end
  end
end