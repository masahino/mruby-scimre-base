module Mrbmacs
  class MakeMode < Mode
    def initialize
      super
      @name = 'make'
      @lexer = 'make'
      @keyword_list = ''
      @start_of_comment = '# '

      @style[Scintilla::SCE_MAKE_DEFAULT] = :color_default
      @style[Scintilla::SCE_MAKE_COMMENT] = :color_comment
      @style[Scintilla::SCE_MAKE_PREPROCESSOR] = :color_preprocessor
      @style[Scintilla::SCE_MAKE_IDENTIFIER] = :color_builtin
      @style[Scintilla::SCE_MAKE_OPERATOR] = :color_default
      @style[Scintilla::SCE_MAKE_TARGET] = :color_function_name
      @style[Scintilla::SCE_MAKE_IDEOL] = :color_default
    end

    def set_style(view_win, theme)
      super
      view_win.sci_set_property('fold.compact', '1')
    end
  end
end
