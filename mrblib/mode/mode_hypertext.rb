module Mrbmacs
  class HtmlMode < Mode
    def initialize
      super.initialize
      @name = 'html'
      @lexer = 'hypertext'
      @keyword_list = ''
      @start_of_comment = '<!-- '
      @end_of_comment = ' -->'
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
        :color_default, # define SCE_H_XMLSTART 12
        :color_default, # define SCE_H_XMLEND 13
        :color_default, # define SCE_H_SCRIPT 14
        :color_default, # define SCE_H_ASP 15
        :color_default, # define SCE_H_ASPAT 16
        :color_default, # define SCE_H_CDATA 17
        :color_default, # define SCE_H_QUESTION 18
        :color_default, # define SCE_H_VALUE 19
        :color_default, # define SCE_H_XCCOMMENT 20
        :color_default, # define SCE_H_SGML_DEFAULT 21
        :color_default, # define SCE_H_SGML_COMMAND 22
        :color_default, # define SCE_H_SGML_1ST_PARAM 23
        :color_default, # define SCE_H_SGML_DOUBLESTRING 24
        :color_default, # define SCE_H_SGML_SIMPLESTRING 25
        :color_default, # define SCE_H_SGML_ERROR 26
        :color_default, # define SCE_H_SGML_SPECIAL 27
        :color_default, # define SCE_H_SGML_ENTITY 28
        :color_comment, # define SCE_H_SGML_COMMENT 29
        :color_default, # define SCE_H_SGML_1ST_PARAM_COMMENT 30
        :color_default, # define SCE_H_SGML_BLOCK_DEFAULT 31
        :color_default, # define SCE_HJ_START 40
        :color_default, # define SCE_HJ_DEFAULT 41
        :color_comment, # define SCE_HJ_COMMENT 42
        :color_comment, # define SCE_HJ_COMMENTLINE 43
        :color_comment, # define SCE_HJ_COMMENTDOC 44
        :color_default, # define SCE_HJ_NUMBER 45
        :color_default, # define SCE_HJ_WORD 46
        :color_default, # define SCE_HJ_KEYWORD 47
        :color_default, # define SCE_HJ_DOUBLESTRING 48
        :color_default, # define SCE_HJ_SINGLESTRING 49
        :color_default, # define SCE_HJ_SYMBOLS 50
        :color_default, # define SCE_HJ_STRINGEOL 51
        :color_default, # define SCE_HJ_REGEX 52
        :color_default, # define SCE_HJA_START 55
        :color_default, # define SCE_HJA_DEFAULT 56
        :color_comment, # define SCE_HJA_COMMENT 57
        :color_comment, # define SCE_HJA_COMMENTLINE 58
        :color_comment, # define SCE_HJA_COMMENTDOC 59
        :color_default, # define SCE_HJA_NUMBER 60
        :color_default, # define SCE_HJA_WORD 61
        :color_default, # define SCE_HJA_KEYWORD 62
        :color_default, # define SCE_HJA_DOUBLESTRING 63
        :color_default, # define SCE_HJA_SINGLESTRING 64
        :color_default, # define SCE_HJA_SYMBOLS 65
        :color_default, # define SCE_HJA_STRINGEOL 66
        :color_default, # define SCE_HJA_REGEX 67
        :color_default, # define SCE_HB_START 70
        :color_default, # define SCE_HB_DEFAULT 71
        :color_comment, # define SCE_HB_COMMENTLINE 72
        :color_default, # define SCE_HB_NUMBER 73
        :color_default, # define SCE_HB_WORD 74
        :color_default, # define SCE_HB_STRING 75
        :color_default, # define SCE_HB_IDENTIFIER 76
        :color_default, # define SCE_HB_STRINGEOL 77
        :color_default, # define SCE_HBA_START 80
        :color_default, # define SCE_HBA_DEFAULT 81
        :color_comment, # define SCE_HBA_COMMENTLINE 82
        :color_default, # define SCE_HBA_NUMBER 83
        :color_default, # define SCE_HBA_WORD 84
        :color_default, # define SCE_HBA_STRING 85
        :color_default, # define SCE_HBA_IDENTIFIER 86
        :color_default, # define SCE_HBA_STRINGEOL 87
        :color_default, # define SCE_HP_START 90
        :color_default, # define SCE_HP_DEFAULT 91
        :color_comment, # define SCE_HP_COMMENTLINE 92
        :color_default, # define SCE_HP_NUMBER 93
        :color_default, # define SCE_HP_STRING 94
        :color_default, # define SCE_HP_CHARACTER 95
        :color_default, # define SCE_HP_WORD 96
        :color_default, # define SCE_HP_TRIPLE 97
        :color_default, # define SCE_HP_TRIPLEDOUBLE 98
        :color_default, # define SCE_HP_CLASSNAME 99
        :color_default, # define SCE_HP_DEFNAME 100
        :color_default, # define SCE_HP_OPERATOR 101
        :color_default, # define SCE_HP_IDENTIFIER 102
        :color_default, # define SCE_HPHP_COMPLEX_VARIABLE 104
        :color_default, # define SCE_HPA_START 105
        :color_default, # define SCE_HPA_DEFAULT 106
        :color_comment, # define SCE_HPA_COMMENTLINE 107
        :color_default, # define SCE_HPA_NUMBER 108
        :color_default, # define SCE_HPA_STRING 109
        :color_default, # define SCE_HPA_CHARACTER 110
        :color_default, # define SCE_HPA_WORD 111
        :color_default, # define SCE_HPA_TRIPLE 112
        :color_default, # define SCE_HPA_TRIPLEDOUBLE 113
        :color_default, # define SCE_HPA_CLASSNAME 114
        :color_default, # define SCE_HPA_DEFNAME 115
        :color_default, # define SCE_HPA_OPERATOR 116
        :color_default, # define SCE_HPA_IDENTIFIER 117
        :color_default, # define SCE_HPHP_DEFAULT 118
        :color_default, # define SCE_HPHP_HSTRING 119
        :color_default, # define SCE_HPHP_SIMPLESTRING 120
        :color_default, # define SCE_HPHP_WORD 121
        :color_default, # define SCE_HPHP_NUMBER 122
        :color_default, # define SCE_HPHP_VARIABLE 123
        :color_comment, # define SCE_HPHP_COMMENT 124
        :color_comment, # define SCE_HPHP_COMMENTLINE 125
        :color_default, # define SCE_HPHP_HSTRING_VARIABLE 126
        :color_default # define SCE_HPHP_OPERATOR 127
      ]
    end

    def set_style(view_win, theme)
      super
      view_win.sci_set_property('fold.html', '1')
    end

    def end_of_block?(line)
      if line =~/^\s*<\/.*>\s*$/
        true
      else
        false
      end
    end
  end
end
