module Mrbmacs
  class XmlMode < Mode
    def initialize
      super.initialize
      @name = 'xml'
      @lexer = 'xml'
      @keyword_list = ''
      @style = [
        :color_foreground, # define SCE_H_DEFAULT 0
        :color_keyword, # define SCE_H_TAG 1
        :color_warning, # define SCE_H_TAGUNKNOWN 2
        :color_variable_name, # define SCE_H_ATTRIBUTE 3
        :color_warning, # define SCE_H_ATTRIBUTEUNKNOWN 4
        :color_foreground, # define SCE_H_NUMBER 5
        :color_string, # define SCE_H_DOUBLESTRING 6
        :color_string, # define SCE_H_SINGLESTRING 7
        :color_foreground, # define SCE_H_OTHER 8
        :color_comment, # define SCE_H_COMMENT 9
        :color_foreground, # define SCE_H_ENTITY 10
        :color_foreground, # define SCE_H_TAGEND 11
        :color_foreground, # 13, "SCE_H_XMLSTART", "identifier", "XML identifier start '<?'"
        :color_foreground, # 14, "SCE_H_XMLEND", "identifier", "XML identifier end '?>'"
        :color_foreground, # 14, "", "unused", "",
        :color_foreground, # 15, "", "unused", "",
        :color_foreground, # 16, "", "unused", "",
        :color_foreground, # 17, "SCE_H_CDATA", "literal", "CDATA",
        :color_foreground, # 18, "SCE_H_QUESTION", "preprocessor", "Question",
        :color_foreground, # 19, "SCE_H_VALUE", "literal string", "Unquoted Value",
        :color_foreground, # 20, "", "unused", "",
        :color_foreground, # 21, "SCE_H_SGML_DEFAULT", "default", "SGML tags <! ... >",
        :color_foreground, # 22, "SCE_H_SGML_COMMAND", "preprocessor", "SGML command",
        :color_foreground, # 23, "SCE_H_SGML_1ST_PARAM", "preprocessor", "SGML 1st param",
        :color_foreground, # 24, "SCE_H_SGML_DOUBLESTRING", "literal string", "SGML double string",
        :color_foreground, # 25, "SCE_H_SGML_SIMPLESTRING", "literal string", "SGML single string",
        :color_foreground, # 26, "SCE_H_SGML_ERROR", "error", "SGML error",
        :color_foreground, # 27, "SCE_H_SGML_SPECIAL", "literal", "SGML special (#XXXX type)",
        :color_foreground, # 28, "SCE_H_SGML_ENTITY", "literal", "SGML entity",
        :color_foreground, # 29, "SCE_H_SGML_COMMENT", "comment", "SGML comment",
        :color_foreground, # 30, "", "unused", "",
        :color_foreground # 31, "SCE_H_SGML_BLOCK_DEFAULT", "default", "SGML block",
      ]
    end

    def set_style(view_win, theme)
      super
      view_win.sci_set_property('fold.html', '1')
    end

    def is_end_of_block(line)
      if line =~ /^\s*<\/.*>\s*$/
        true
      else
        false
      end
    end
  end
end
