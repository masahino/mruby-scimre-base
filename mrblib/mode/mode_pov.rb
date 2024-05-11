module Mrbmacs
  class PovMode < Mode
    def initialize
      super
      @name = 'pov'
      @lexer = 'pov'
      @keyword_list = ''
      @start_of_comment = '# '

      @style[Scintilla::SCE_POV_DEFAULT] = :color_default
      @style[Scintilla::SCE_POV_COMMENT] = :color_comment
      @style[Scintilla::SCE_POV_COMMENTLINE] = :color_comment
      @style[Scintilla::SCE_POV_NUMBER] = :color_default
      @style[Scintilla::SCE_POV_OPERATOR] = :color_default
      @style[Scintilla::SCE_POV_IDENTIFIER] = :color_default
      @style[Scintilla::SCE_POV_STRING] = :color_string
      @style[Scintilla::SCE_POV_STRINGEOL] = :color_string
      @style[Scintilla::SCE_POV_DIRECTIVE] = :color_default
      @style[Scintilla::SCE_POV_BADDIRECTIVE] = :color_foregrond
      @style[Scintilla::SCE_POV_WORD2] = :color_keyword
      @style[Scintilla::SCE_POV_WORD3] = :color_keyword
      @style[Scintilla::SCE_POV_WORD4] = :color_keyword
      @style[Scintilla::SCE_POV_WORD5] = :color_keyword
      @style[Scintilla::SCE_POV_WORD6] = :color_keyword
      @style[Scintilla::SCE_POV_WORD7] = :color_keyword
      @style[Scintilla::SCE_POV_WORD8] = :color_keyword
    end

    def set_style(view_win, theme)
      super
      view_win.sci_set_property('fold.compact', '1')
    end
  end
end
