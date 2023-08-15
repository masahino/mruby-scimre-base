module Mrbmacs
  class RMode < Mode
    def initialize
      super.initialize
      @name = 'r'
      @lexer = 'r'
      @keyword_list = 'if else repeat while function for in next break TRUE FALSE NULL NA Inf NaN'
      @start_of_comment = '# '
      @style = [
        :color_foreground, # define SCE_R_DEFAULT 0
        :color_comment, # define SCE_R_COMMENT 1
        :color_builtin, # define SCE_R_KWORD 2
        :color_keyword, # define SCE_R_BASEKWORD 3
        :color_keyword, # define SCE_R_OTHERKWORD 4
        :color_foreground, # define SCE_R_NUMBER 5
        :color_string, # define SCE_R_STRING 6
        :color_string, # define SCE_R_STRING2 7
        :color_foreground, # define SCE_R_OPERATOR 8
        :color_foreground, # define SCE_R_IDENTIFIER 9
        :color_foreground, # define SCE_R_INFIX 10
        :color_foreground # define SCE_R_INFIXEOL 11
      ]
    end

    def set_style(view_win, theme)
      super
      view_win.sci_set_property('fold.compact', '1')
    end

    def is_end_of_block(line)
      if line =~ /^\s*}.*$/
        true
      else
        false
      end
    end
  end
end
