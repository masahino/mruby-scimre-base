module Mrbmacs
  class LatexMode < Mode
    def initialize
      super
      @name = 'latex'
      @lexer = 'latex'
      @keyword_list = ''
      @start_of_comment = '% '

      @style[Scintilla::SCE_L_DEFAULT] = :color_default
      @style[Scintilla::SCE_L_COMMAND] = :color_builtin
      @style[Scintilla::SCE_L_TAG] = :color_variable_name
      @style[Scintilla::SCE_L_MATH] = :color_default
      @style[Scintilla::SCE_L_COMMENT] = :color_comment
      @style[Scintilla::SCE_L_TAG2] = :color_variable_name
      @style[Scintilla::SCE_L_MATH2] = :color_default
      @style[Scintilla::SCE_L_COMMENT2] = :color_comment
      @style[Scintilla::SCE_L_VERBATIM] = :color_default
      @style[Scintilla::SCE_L_SHORTCMD] = :color_default
      @style[Scintilla::SCE_L_SPECIAL] = :color_default
      @style[Scintilla::SCE_L_CMDOPT] = :color_default
      @style[Scintilla::SCE_L_ERROR] = :color_warning
    end

    def set_style(view_win, theme)
      super
      view_win.sci_set_property('fold.compact', '1')
    end
  end
end
