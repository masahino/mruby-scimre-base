module Mrbmacs
  class CssMode < Mode
    def initialize
      super
      @name = 'css'
      @lexer = 'css'
      @keyword_list = ''
      @start_of_comment = '/* '
      @end_of_comment = ' */'
      @style[Scintilla::SCE_CSS_DEFAULT] = :color_default
      @style[Scintilla::SCE_CSS_TAG] = :color_default
      @style[Scintilla::SCE_CSS_CLASS] = :color_default
      @style[Scintilla::SCE_CSS_PSEUDOCLASS] = :color_default
      @style[Scintilla::SCE_CSS_UNKNOWN_PSEUDOCLASS] = :color_default
      @style[Scintilla::SCE_CSS_OPERATOR] = :color_default
      @style[Scintilla::SCE_CSS_IDENTIFIER] = :color_default
      @style[Scintilla::SCE_CSS_UNKNOWN_IDENTIFIER] = :color_default
      @style[Scintilla::SCE_CSS_VALUE] = :color_default
      @style[Scintilla::SCE_CSS_COMMENT] = :color_comment
      @style[Scintilla::SCE_CSS_ID] = :color_default
      @style[Scintilla::SCE_CSS_IMPORTANT] = :color_default
      @style[Scintilla::SCE_CSS_DIRECTIVE] = :color_default
      @style[Scintilla::SCE_CSS_DOUBLESTRING] = :color_string
      @style[Scintilla::SCE_CSS_SINGLESTRING] = :color_string
      @style[Scintilla::SCE_CSS_IDENTIFIER2] = :color_default
      @style[Scintilla::SCE_CSS_ATTRIBUTE] = :color_default
      @style[Scintilla::SCE_CSS_IDENTIFIER3] = :color_default
      @style[Scintilla::SCE_CSS_PSEUDOELEMENT] = :color_default
      @style[Scintilla::SCE_CSS_EXTENDED_IDENTIFIER] = :color_default
      @style[Scintilla::SCE_CSS_EXTENDED_PSEUDOCLASS] = :color_default
      @style[Scintilla::SCE_CSS_EXTENDED_PSEUDOELEMENT] = :color_default
      @style[Scintilla::SCE_CSS_GROUP_RULE] = :color_default
      @style[Scintilla::SCE_CSS_VARIABLE] = :color_variable_name
    end

    def set_style(view_win, theme)
      super
      view_win.sci_set_property('fold.compact', '1')
    end
  end
end
