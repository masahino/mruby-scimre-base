module Mrbmacs
  class FrameBase
    include Scintilla
    attr_accessor :view_win, :echo_win, :tk, :sci_notifications, :edit_win_list, :edit_win

    def init_keysyms
      @keysyms = [0,
                  Scintilla::SCK_BACK,
                  Scintilla::SCK_TAB,
                  Scintilla::SCK_RETURN,
                  Scintilla::SCK_ESCAPE,
                  0,
                  Scintilla::SCK_BACK,
                  Scintilla::SCK_UP,
                  Scintilla::SCK_DOWN,
                  Scintilla::SCK_LEFT,
                  Scintilla::SCK_RIGHT,
                  0, 0,
                  Scintilla::SCK_INSERT,
                  Scintilla::SCK_DELETE,
                  0,
                  Scintilla::SCK_PRIOR,
                  Scintilla::SCK_NEXT,
                  Scintilla::SCK_HOME,
                  Scintilla::SCK_END]
    end

    def set_theme(theme)
      @edit_win_list.each do |w|
        w.set_theme(theme)
      end
    end

    def get_mode_str(app)
      app.modeline_str
    end

    # (ENCODING-EOL):---____FILENAME____________(X,Y)_____[MODE____][ADDITIONAL-INFO__]
    def get_mode_str_builtin(app)
      newline = @edit_win.newline
      mode_text = " (#{app.current_buffer.encoding}-#{newline}):"
      if @view_win.sci_get_modify != 0
        if @view_win.sci_get_readonly != 0
          mode_text += '%*'
        else
          mode_text += '**'
        end
      elsif @view_win.sci_get_readonly != 0
        mode_text += '%%'
      else
        mode_text += '--'
      end
      mode_text += sprintf('    %-20s', app.current_buffer.name)
      x = @view_win.sci_get_column(@view_win.sci_get_current_pos) + 1
      y = @view_win.sci_line_from_position(@view_win.sci_get_current_pos) + 1
      mode_text += sprintf('%-10s', "(#{x},#{y})")
      mode_text += sprintf('%-10s', '[' + app.current_buffer.mode.name + ']')
      mode_text += sprintf('%-20s', '[' + app.current_buffer.additional_info + ']')
      mode_text
    end

    def set_buffer_name(name)
    end

    def echo_set_prompt(prompt)
    end

    def read_buffername(prompt)
      echo_gets(prompt)
    end

    def show_annotation(line, column, message, style = 254)
      #      text = sprintf "line %d: %s", line, message
      text = message
      @view_win.sci_annotation_set_text(line - 1, text)
      @view_win.sci_annotation_set_style(line - 1, style)
    end

    def echo_gets(prompt, text = '', &block)
      raise NotImplementedError
    end

    def echo_style_base(echo_win)
      echo_win.sci_style_clear_all
      echo_win.sci_set_focus(false)
      echo_win.sci_autoc_set_choose_single(1)
      echo_win.sci_autoc_set_auto_hide(false)
      echo_win.sci_set_margin_typen(3, 4)
      echo_win.sci_set_caretstyle Scintilla::CARETSTYLE_BLOCK_AFTER | Scintilla::CARETSTYLE_OVERSTRIKE_BLOCK | Scintilla::CARETSTYLE_BLOCK
      echo_win.sci_set_wrap_mode(Scintilla::SC_WRAP_CHAR)
      if Scintilla::PLATFORM != :CURSES_WIN32
        echo_win.sci_autoc_set_max_height(16)
      end
    end

    def echo_puts(text)
      raise NotImplementedError
    end

    def sync_tab(buffername)
    end

    def edit_win_from_buffer(buffer_name)
      @edit_win_list.each do |w|
        return w if w.buffer.name == buffer_name
      end
      nil
    end

    def get_edit_win_from_pos(line, col)
      @edit_win_list.each do |w|
        if line >= w.y1 && line <= w.y2 && col >= w.x1 && col <= w.x2
          return w
        end
      end
      nil
    end

    def switch_window(new_win)
      @edit_win.focus_out
      @edit_win = new_win
      @view_win = new_win.sci
      @mode_win = new_win.mode_win
      new_win.focus_in
    end

    def refresh_all
      @edit_win_list.each do |win|
        win.refresh
      end
    end

    def exit
      raise NotImplementedError
    end
  end

  class Frame < FrameBase
  end
end
