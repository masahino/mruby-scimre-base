module Mrbmacs
  class CssMode < Mode
    include Scintilla
    def initialize
      super.initialize
      @name = "css"
      @lexer = "css"
      @keyword_list = ""
      @style = [
        :color_foreground, #define SCE_CSS_DEFAULT 0
        :color_foregrond, #define SCE_CSS_TAG 1
        :color_foreground, #define SCE_CSS_CLASS 2
        :color_foreground, #define SCE_CSS_PSEUDOCLASS 3
        :color_foreground, #define SCE_CSS_UNKNOWN_PSEUDOCLASS 4
        :color_foreground, #define SCE_CSS_OPERATOR 5
        :color_foreground, #define SCE_CSS_IDENTIFIER 6
        :color_foreground, #define SCE_CSS_UNKNOWN_IDENTIFIER 7
        :color_foreground, #define SCE_CSS_VALUE 8
        :color_comment, #define SCE_CSS_COMMENT 9
        :color_foreground, #define SCE_CSS_ID 10
        :color_foreground, #define SCE_CSS_IMPORTANT 11
        :color_foreground, #define SCE_CSS_DIRECTIVE 12
        :color_string, #define SCE_CSS_DOUBLESTRING 13
        :color_string, #define SCE_CSS_SINGLESTRING 14
        :color_foreground, #define SCE_CSS_IDENTIFIER2 15
        :color_foreground, #define SCE_CSS_ATTRIBUTE 16
        :color_foreground, #define SCE_CSS_IDENTIFIER3 17
        :color_foreground, #define SCE_CSS_PSEUDOELEMENT 18
        :color_foreground, #define SCE_CSS_EXTENDED_IDENTIFIER 19
        :color_foreground, #define SCE_CSS_EXTENDED_PSEUDOCLASS 20
        :color_foreground, #define SCE_CSS_EXTENDED_PSEUDOELEMENT 21
        :color_foreground, #define SCE_CSS_MEDIA 22
        :color_variable_name, #define SCE_CSS_VARIABLE 23
          ]
    end

    def set_style(view_win, theme)
      super
      view_win.sci_set_property("fold.compact", "1")
    end

  end
end
