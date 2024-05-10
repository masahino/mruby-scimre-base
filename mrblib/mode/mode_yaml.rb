module Mrbmacs
  class YamlMode < Mode
    def initialize
      super.initialize
      @name = 'yaml'
      @lexer = 'yaml'
      @keyword_list = ''
      @style = [
        :color_default, # define SCE_YAML_DEFAULT 0
        :color_comment, # define SCE_YAML_COMMENT 1
        :color_string, # define SCE_YAML_IDENTIFIER 2
        :color_keyword, # define SCE_YAML_KEYWORD 3
        :color_default, # define SCE_YAML_NUMBER 4
        :color_default, # define SCE_YAML_REFERENCE 5
        :color_doc, # define SCE_YAML_DOCUMENT 6
        :color_string, # define SCE_YAML_TEXT 7
        :color_warning, # define SCE_YAML_ERROR 8
        :color_default # define SCE_YAML_OPERATOR 9
      ]
    end

    def set_style(view_win, theme)
      super
      view_win.sci_set_property('fold.compact', '1')
    end
  end
end
