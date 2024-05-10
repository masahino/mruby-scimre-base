module Mrbmacs
  class BashMode < Mode
    def initialize
      super.initialize
      @name = 'bash'
      @lexer = 'bash'
      @keyword_list = ''
      @start_of_comment = '# '
      @style = [
        :color_default, # define SCE_SH_DEFAULT 0
        :color_warning, # define SCE_SH_ERROR 1
        :color_comment, # define SCE_SH_COMMENTLINE 2
        :color_default, # define SCE_SH_NUMBER 3
        :color_keyword, # define SCE_SH_WORD 4
        :color_string, # define SCE_SH_STRING 5
        :color_default, # define SCE_SH_CHARACTER 6
        :color_default, # define SCE_SH_OPERATOR 7
        :color_default, # define SCE_SH_IDENTIFIER 8
        :color_default, # define SCE_SH_SCALAR 9
        :color_default, # define SCE_SH_PARAM 10
        :color_default, # define SCE_SH_BACKTICKS 11
        :color_default, # define SCE_SH_HERE_DELIM 12
        :color_default # define SCE_SH_HERE_Q 13
      ]
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
  end
end
