module Mrbmacs
  class HaskellMode < Mode
    def initialize
      super
      @name = 'haskell'
      @lexer = 'haskell'
      @keyword_list = "case class data default deriving do else hiding if \
      import in infix infixl infixr instance let module \
      newtype of then type where forall foreign"
      @start_of_comment = '-- '

      @style[Scintilla::SCE_HA_DEFAULT] = :color_default
      @style[Scintilla::SCE_HA_IDENTIFIER] = :color_default
      @style[Scintilla::SCE_HA_KEYWORD] = :color_keyword
      @style[Scintilla::SCE_HA_NUMBER] = :color_default
      @style[Scintilla::SCE_HA_STRING] = :color_string
      @style[Scintilla::SCE_HA_CHARACTER] = :color_string
      @style[Scintilla::SCE_HA_CLASS] = :color_type
      @style[Scintilla::SCE_HA_MODULE] = :color_type
      @style[Scintilla::SCE_HA_CAPITAL] = :color_default
      @style[Scintilla::SCE_HA_DATA] = :color_default
      @style[Scintilla::SCE_HA_IMPORT] = :color_default
      @style[Scintilla::SCE_HA_OPERATOR] = :color_default
      @style[Scintilla::SCE_HA_INSTANCE] = :color_default
      @style[Scintilla::SCE_HA_COMMENTLINE] = :color_comment
      @style[Scintilla::SCE_HA_COMMENTBLOCK] = :color_comment
      @style[Scintilla::SCE_HA_COMMENTBLOCK2] = :color_comment
      @style[Scintilla::SCE_HA_COMMENTBLOCK3] = :color_comment
      @style[Scintilla::SCE_HA_PRAGMA] = :color_default
      @style[Scintilla::SCE_HA_PREPROCESSOR] = :color_preprocessor
      @style[Scintilla::SCE_HA_STRINGEOL] = :color_string
      @style[Scintilla::SCE_HA_RESERVED_OPERATOR] = :color_default
      @style[Scintilla::SCE_HA_LITERATE_COMMENT] = :color_comment
      @style[Scintilla::SCE_HA_LITERATE_CODEDELIM] = :color_default
    end

    def set_style(view_win, theme)
      super
      view_win.sci_set_property('fold.compact', '1')
    end
  end
end
