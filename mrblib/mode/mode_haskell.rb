module Mrbmacs
  class HaskellMode < Mode
    def initialize
      super.initialize
      @name = 'haskell'
      @lexer = 'haskell'
      @keyword_list = "case class data default deriving do else hiding if \
      import in infix infixl infixr instance let module \
      newtype of then type where forall foreign"
      @start_of_comment = '-- '
      @style = [
        :color_default, # define SCE_HA_DEFAULT 0
        :color_default, # define SCE_HA_IDENTIFIER 1
        :color_keyword, # define SCE_HA_KEYWORD 2
        :color_default, # define SCE_HA_NUMBER 3
        :color_string, # define SCE_HA_STRING 4
        :color_string, # define SCE_HA_CHARACTER 5
        :color_type, # define SCE_HA_CLASS 6
        :color_type, # define SCE_HA_MODULE 7
        :color_default, # define SCE_HA_CAPITAL 8
        :color_default, # define SCE_HA_DATA 9
        :color_default, # define SCE_HA_IMPORT 10
        :color_default, # define SCE_HA_OPERATOR 11
        :color_default, # define SCE_HA_INSTANCE 12
        :color_comment, # define SCE_HA_COMMENTLINE 13
        :color_comment, # define SCE_HA_COMMENTBLOCK 14
        :color_comment, # define SCE_HA_COMMENTBLOCK2 15
        :color_comment, # define SCE_HA_COMMENTBLOCK3 16
        :color_default, # define SCE_HA_PRAGMA 17
        :color_preprocessor, # define SCE_HA_PREPROCESSOR 18
        :color_string, # define SCE_HA_STRINGEOL 19
        :color_default, # define SCE_HA_RESERVED_OPERATOR 20
        :color_comment, # define SCE_HA_LITERATE_COMMENT 21
        :color_default # define SCE_HA_LITERATE_CODEDELIM 22
      ]
    end

    def set_style(view_win, theme)
      super
      view_win.sci_set_property('fold.compact', '1')
    end
  end
end
