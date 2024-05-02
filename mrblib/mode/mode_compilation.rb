module Mrbmacs
  # compilation mode
  class CompilationMode < Mode
    SCE_STYLE_DEFAULT = 0
    SCE_STYLE_ERROR = 1
    SCE_STYLE_FILE = 2
    SCE_STYLE_NUMBER = 3
    def initialize
      super.initialize
      @name = 'compilation'
      @lexer = nil
      @keyword_list = ''
      @style = [
        :color_foreground,    # 0: default
        :color_warning,       # 1: error message
        :color_function_name, # 2: file path
        :color_keyword,       # 3: number
        :color_string,        # 4: reserve
        :color_comment        # 5: reserve
      ]
      @keymap['Enter'] = 'compilation_open_file'
    end

    def set_style(view_win, theme)
      super
      view_win.sci_set_property('fold.compact', '1')
    end

    def end_of_block?(line)
      if line =~ /^\s*(end|else|fi|done|}).*$/
        true
      else
        false
      end
    end

    def on_style_needed(app, scn)
      start_line = app.frame.view_win.sci_line_from_position(app.frame.view_win.sci_get_end_styled)
      end_pos = scn['position']
      end_line = app.frame.view_win.sci_line_from_position(end_pos)
      for i in start_line..end_line
        pos = app.frame.view_win.sci_position_from_line(i)
        line_length = app.frame.view_win.sci_line_length(i)
        next if line_length == 0

        app.frame.view_win.sci_start_styling(pos, 0)
        line = app.frame.view_win.sci_get_line(i)
        # /foo/bar/baz/hoge.rb:7:7: syntax error, unexpected keyword_end
        #          if line =~ /^(\/.+):(\d+):(\d+): (.+)$/
        if line =~ /^(\/.+):(\d+):(\d+): (.+)$/
          app.frame.view_win.sci_set_styling(Regexp.last_match[1].length, SCE_STYLE_FILE) # file
          app.frame.view_win.sci_set_styling(1, SCE_STYLE_DEFAULT) # :
          app.frame.view_win.sci_set_styling(Regexp.last_match[2].to_s.length, SCE_STYLE_NUMBER) # line
          app.frame.view_win.sci_set_styling(1, SCE_STYLE_DEFAULT) # :
          app.frame.view_win.sci_set_styling(Regexp.last_match[3].to_s.length, SCE_STYLE_NUMBER) # col
          app.frame.view_win.sci_set_styling(2, SCE_STYLE_DEFAULT) # :
          app.frame.view_win.sci_set_styling(Regexp.last_match[4].length, SCE_STYLE_ERROR) # message
        else
          app.frame.view_win.sci_set_styling(line_length, SCE_STYLE_DEFAULT)
        end
      end
    end
  end

  class Application
    def compilation_open_file
      line_str = @frame.view_win.sci_get_curline[0]
      if line_str =~ /^(\/.+):(\d+):(\d+): (.+)$/
        split_window if @frame.edit_win_list.size == 1
        other_window
        file = Regexp.last_match[1]
        line = Regexp.last_match[2].to_i - 1
        col = Regexp.last_match[3].to_i
        find_file(file)
        pos = @frame.view_win.sci_position_from_line(line) + col
        @frame.view_win.sci_goto_pos(pos)
      end
    end
  end
end
