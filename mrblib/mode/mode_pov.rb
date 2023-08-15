module Mrbmacs
  class PovMode < Mode
    def initialize
      super.initialize
      @name = 'pov'
      @lexer = 'pov'
      @keyword_list = ''
      @start_of_comment = '# '
      @style = [
        :color_foreground, # #define SCE_POV_DEFAULT 0
        :color_comment, # #define SCE_POV_COMMENT 1
        :color_comment, # #define SCE_POV_COMMENTLINE 2
        :color_foreground, # #define SCE_POV_NUMBER 3
        :color_foreground, # #define SCE_POV_OPERATOR 4
        :color_foreground, # #define SCE_POV_IDENTIFIER 5
        :color_string, # #define SCE_POV_STRING 6
        :color_string, # #define SCE_POV_STRINGEOL 7
        :color_foreground, # #define SCE_POV_DIRECTIVE 8
        :color_foregrond, # #define SCE_POV_BADDIRECTIVE 9
        :color_keyword, # #define SCE_POV_WORD2 10
        :color_keyword, # #define SCE_POV_WORD3 11
        :color_keyword, # #define SCE_POV_WORD4 12
        :color_keyword, # #define SCE_POV_WORD5 13
        :color_keyword, # #define SCE_POV_WORD6 14
        :color_keyword, # #define SCE_POV_WORD7 15
        :color_keyword # #define SCE_POV_WORD8 16
      ]
    end

    def set_style(view_win, theme)
      super
      view_win.sci_set_property('fold.compact', '1')
    end
  end
end
