module Mrbmacs
  # grep
  class GrepMode < Mode
    attr_reader :pattern

    include Scintilla

    SCE_STYLE_DEFAULT = 0
    SCE_STYLE_FILE = 1
    SCE_STYLE_NUMBER = 2
    SCE_STYLE_PATTERN = 3
    def initialize
      super.initialize
      @name = 'grep'
      @lexer = nil
      @keyword_list = ''
      @style = [
        :color_foreground,    # 0: default
        :color_function_name, # 1: file path
        :color_keyword,       # 2: number
        :color_warning,       # 3: pattern
        :color_string,        # 4: reserve
        :color_comment        # 5: reserve
      ]
      @keymap['Enter'] = 'grep_open_file'
      @pattern = ''
    end

    def pattern=(pattern)
      @pattern = pattern
    end

    def set_style(view_win, theme)
      super
      view_win.sci_set_property('fold.compact', '1')
    end

    def is_end_of_block(_line)
      false
    end

    def set_lexer(view_win) end

    def on_style_needed(app, scn)
      start_line = app.frame.view_win.sci_line_from_position(app.frame.view_win.sci_get_end_styled)

      end_pos = scn['position']
      end_line = app.frame.view_win.sci_line_from_position(end_pos)
      for i in start_line..end_line
        pos = app.frame.view_win.sci_position_from_line(i)
        line_length = app.frame.view_win.sci_line_length(i)
        pattern = app.current_buffer.mode.pattern
        next if line_length == 0

        app.frame.view_win.sci_start_styling(pos, 0)
        line = app.frame.view_win.sci_get_line(i)
        # /foo/bar/baz/hoge.rb:7: syntax error, unexpected keyword_end
        if line =~ /^(.+):(\d+):(.*)(#{pattern})(.*)$/
          app.frame.view_win.sci_set_styling(Regexp.last_match[1].length, SCE_STYLE_FILE) # file
          app.frame.view_win.sci_set_styling(1, SCE_STYLE_DEFAULT) # :
          app.frame.view_win.sci_set_styling(Regexp.last_match[2].to_s.length, SCE_STYLE_NUMBER) # line
          app.frame.view_win.sci_set_styling(1, SCE_STYLE_DEFAULT) # :
          app.frame.view_win.sci_set_styling(Regexp.last_match[3].length, SCE_STYLE_DEFAULT) # normal text
          app.frame.view_win.sci_set_styling(Regexp.last_match[4].length, SCE_STYLE_PATTERN) # match pattern
          app.frame.view_win.sci_set_styling(Regexp.last_match[5].length, SCE_STYLE_DEFAULT) # match pattern
        else
          app.frame.view_win.sci_set_styling(line_length, SCE_STYLE_DEFAULT)
        end
      end
    end

    def self.extract_pattern(command_str)
      command_str.split(/\s+/)[1..-2].each do |str|
        return str if str[0] != '-'
      end
      ''
    end
  end

  class Application
    def grep_open_file
      line_str = @frame.view_win.sci_get_curline[0]
      if line_str =~ /^(.+):(\d+):(.+)$/
        split_window if @frame.edit_win_list.size == 1
        other_window
        file = Regexp.last_match[1]
        line = Regexp.last_match[2].to_i - 1
        find_file(file)
        pos = @frame.view_win.sci_position_from_line(line)
        @frame.view_win.sci_goto_pos(pos)
      end
    end
  end
end
