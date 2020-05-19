# coding: utf-8
module Mrbmacs
  class Frame
    include Scintilla
    attr_accessor :view_win, :echo_win, :tk, :sci_notifications
    attr_accessor :edit_win_list, :edit_win

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
                  0,0,
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

    # (ENCODING-EOL):---____FILENAME____________(X,Y)_____[MODE____][ADDITIONAL-INFO__]
    def get_mode_str(app)
      newline = case @view_win.sci_get_eol_mode
      when 0
#        "dos"
        "CRLF"
      when 1
#        "mac"
        "CR"
      when 2
#        "unix"
        "LF"
      else
        ""
      end
      mode_text = " (#{app.current_buffer.encoding}-#{newline}):"
      if @view_win.sci_get_modify != 0
        if @view_win.sci_get_readonly != 0
          mode_text += "%*"
        else
          mode_text += "**"
        end
      elsif @view_win.sci_get_readonly != 0
        mode_text += "%%"
      else
        mode_text += "--"
      end
      mode_text += sprintf("    %-20s", app.current_buffer.name)
      x = @view_win.sci_get_column(@view_win.sci_get_current_pos)+1
      y = @view_win.sci_line_from_position(@view_win.sci_get_current_pos)+1
      mode_text += sprintf("%-10s", "(#{x},#{y})")
      mode_text += sprintf("%-10s", "["+app.current_buffer.mode.name+"]")
      mode_text += sprintf("%-20s", "["+app.current_buffer.additional_info+"]")
    end

    def set_buffer_name(name)
    end

    def echo_set_prompt(prompt)
    end

    def read_buffername(prompt)
      echo_gets(prompt)
    end

    def show_annotation(line, column, message)
      text = sprintf "line %d: %s", line, message
      @view_win.sci_annotation_set_text(line-1, text)
      @view_win.sci_annotation_set_style(line-1, 254)
    end

    def echo_gets(prompt, text = "", &block)
      raise NotImplementedError
    end

    def echo_puts(text)
      raise NotImplementedError
    end

    def sync_tab(buffername)
    end

    def exit()
      raise NotImplementedError
    end
  end
end
