module Mrbmacs
  class DiffMode < Mode
    def initialize
      super
      @name = 'diff'
      @lexer = 'diff'
      @keyword_list = ''
      @style[Scintilla::SCE_DIFF_DEFAULT] = :color_default
      @style[Scintilla::SCE_DIFF_COMMENT] = :color_comment
      @style[Scintilla::SCE_DIFF_COMMAND] = :color_default
      @style[Scintilla::SCE_DIFF_HEADER] = :color_default
      @style[Scintilla::SCE_DIFF_POSITION] = :color_builtin
      @style[Scintilla::SCE_DIFF_DELETED] = :color_variable_name
      @style[Scintilla::SCE_DIFF_ADDED] = :color_string
      @style[Scintilla::SCE_DIFF_CHANGED] = :color_keyword
      @style[Scintilla::SCE_DIFF_PATCH_ADD] = :color_string
      @style[Scintilla::SCE_DIFF_PATCH_DELETE] = :color_variable_name
      @style[Scintilla::SCE_DIFF_REMOVED_PATCH_ADD] = :color_variable_name
      @style[Scintilla::SCE_DIFF_REMOVED_PATCH_DELETE] = :color_variable_name
    end

    def set_style(view_win, theme)
      super
      view_win.sci_set_property('fold.compact', '1')
    end
  end
end
