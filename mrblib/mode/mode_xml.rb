module Mrbmacs
  class XmlMode < Mode
    def initialize
      super.initialize
      @name = 'xml'
      @lexer = 'xml'
      @keyword_list = ''
      @style = [
        :color_default, # define SCE_H_DEFAULT 0
        :color_keyword, # define SCE_H_TAG 1
        :color_warning, # define SCE_H_TAGUNKNOWN 2
        :color_variable_name, # define SCE_H_ATTRIBUTE 3
        :color_warning, # define SCE_H_ATTRIBUTEUNKNOWN 4
        :color_default, # define SCE_H_NUMBER 5
        :color_string, # define SCE_H_DOUBLESTRING 6
        :color_string, # define SCE_H_SINGLESTRING 7
        :color_default, # define SCE_H_OTHER 8
        :color_comment, # define SCE_H_COMMENT 9
        :color_default, # define SCE_H_ENTITY 10
        :color_default, # define SCE_H_TAGEND 11
        :color_default, # 13, "SCE_H_XMLSTART", "identifier", "XML identifier start '<?'"
        :color_default, # 14, "SCE_H_XMLEND", "identifier", "XML identifier end '?>'"
        :color_default, # 14, "", "unused", "",
        :color_default, # 15, "", "unused", "",
        :color_default, # 16, "", "unused", "",
        :color_default, # 17, "SCE_H_CDATA", "literal", "CDATA",
        :color_default, # 18, "SCE_H_QUESTION", "preprocessor", "Question",
        :color_default, # 19, "SCE_H_VALUE", "literal string", "Unquoted Value",
        :color_default, # 20, "", "unused", "",
        :color_default, # 21, "SCE_H_SGML_DEFAULT", "default", "SGML tags <! ... >",
        :color_default, # 22, "SCE_H_SGML_COMMAND", "preprocessor", "SGML command",
        :color_default, # 23, "SCE_H_SGML_1ST_PARAM", "preprocessor", "SGML 1st param",
        :color_default, # 24, "SCE_H_SGML_DOUBLESTRING", "literal string", "SGML double string",
        :color_default, # 25, "SCE_H_SGML_SIMPLESTRING", "literal string", "SGML single string",
        :color_default, # 26, "SCE_H_SGML_ERROR", "error", "SGML error",
        :color_default, # 27, "SCE_H_SGML_SPECIAL", "literal", "SGML special (#XXXX type)",
        :color_default, # 28, "SCE_H_SGML_ENTITY", "literal", "SGML entity",
        :color_default, # 29, "SCE_H_SGML_COMMENT", "comment", "SGML comment",
        :color_default, # 30, "", "unused", "",
        :color_default # 31, "SCE_H_SGML_BLOCK_DEFAULT", "default", "SGML block",
      ]
    end

    def set_style(view_win, theme)
      super
      view_win.sci_set_property('fold.html', '1')
    end

    def end_of_block?(line)
      if line =~ /^\s*<\/.*>\s*$/
        true
      else
        false
      end
    end
  end
end
