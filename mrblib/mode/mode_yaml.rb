module Mrbmacs
  class YamlMode < Mode
    def initialize
      super
      @name = 'yaml'
      @lexer = 'yaml'
      @keyword_list = ''

      @style[Scintilla::SCE_YAML_DEFAULT] = :color_default
      @style[Scintilla::SCE_YAML_COMMENT] = :color_comment
      @style[Scintilla::SCE_YAML_IDENTIFIER] = :color_string
      @style[Scintilla::SCE_YAML_KEYWORD] = :color_keyword
      @style[Scintilla::SCE_YAML_NUMBER] = :color_default
      @style[Scintilla::SCE_YAML_REFERENCE] = :color_default
      @style[Scintilla::SCE_YAML_DOCUMENT] = :color_doc
      @style[Scintilla::SCE_YAML_TEXT] = :color_string
      @style[Scintilla::SCE_YAML_ERROR] = :color_warning
      @style[Scintilla::SCE_YAML_OPERATOR] = :color_default
    end

    def set_style(view_win, theme)
      super
      view_win.sci_set_property('fold.compact', '1')
    end
  end
end
