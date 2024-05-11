module Mrbmacs
  class HtmlMode < Mode
    def initialize
      super
      @name = 'html'
      @lexer = 'hypertext'
      @keyword_list = ''
      @start_of_comment = '<!-- '
      @end_of_comment = ' -->'

      @style[Scintilla::SCE_H_DEFAULT] = :color_default
      @style[Scintilla::SCE_H_TAG] = :color_keyword
      @style[Scintilla::SCE_H_TAGUNKNOWN] = :color_warning
      @style[Scintilla::SCE_H_ATTRIBUTE] = :color_variable_name
      @style[Scintilla::SCE_H_ATTRIBUTEUNKNOWN] = :color_warning
      @style[Scintilla::SCE_H_NUMBER] = :color_default
      @style[Scintilla::SCE_H_DOUBLESTRING] = :color_string
      @style[Scintilla::SCE_H_SINGLESTRING] = :color_string
      @style[Scintilla::SCE_H_OTHER] = :color_default
      @style[Scintilla::SCE_H_COMMENT] = :color_comment
      @style[Scintilla::SCE_H_ENTITY] = :color_default
      @style[Scintilla::SCE_H_TAGEND] = :color_default
      @style[Scintilla::SCE_H_XMLSTART] = :color_default
      @style[Scintilla::SCE_H_XMLEND] = :color_default
      @style[Scintilla::SCE_H_SCRIPT] = :color_default
      @style[Scintilla::SCE_H_ASP] = :color_default
      @style[Scintilla::SCE_H_ASPAT] = :color_default
      @style[Scintilla::SCE_H_CDATA] = :color_default
      @style[Scintilla::SCE_H_QUESTION] = :color_default
      @style[Scintilla::SCE_H_VALUE] = :color_default
      @style[Scintilla::SCE_H_XCCOMMENT] = :color_default
      @style[Scintilla::SCE_H_SGML_DEFAULT] = :color_default
      @style[Scintilla::SCE_H_SGML_COMMAND] = :color_default
      @style[Scintilla::SCE_H_SGML_1ST_PARAM] = :color_default
      @style[Scintilla::SCE_H_SGML_DOUBLESTRING] = :color_default
      @style[Scintilla::SCE_H_SGML_SIMPLESTRING] = :color_default
      @style[Scintilla::SCE_H_SGML_ERROR] = :color_default
      @style[Scintilla::SCE_H_SGML_SPECIAL] = :color_default
      @style[Scintilla::SCE_H_SGML_ENTITY] = :color_default
      @style[Scintilla::SCE_H_SGML_COMMENT] = :color_comment
      @style[Scintilla::SCE_H_SGML_1ST_PARAM_COMMENT] = :color_default
      @style[Scintilla::SCE_H_SGML_BLOCK_DEFAULT] = :color_default
      @style[Scintilla::SCE_HJ_START] = :color_default
      @style[Scintilla::SCE_HJ_DEFAULT] = :color_default
      @style[Scintilla::SCE_HJ_COMMENT] = :color_comment
      @style[Scintilla::SCE_HJ_COMMENTLINE] = :color_comment
      @style[Scintilla::SCE_HJ_COMMENTDOC] = :color_comment
      @style[Scintilla::SCE_HJ_NUMBER] = :color_default
      @style[Scintilla::SCE_HJ_WORD] = :color_default
      @style[Scintilla::SCE_HJ_KEYWORD] = :color_default
      @style[Scintilla::SCE_HJ_DOUBLESTRING] = :color_default
      @style[Scintilla::SCE_HJ_SINGLESTRING] = :color_default
      @style[Scintilla::SCE_HJ_SYMBOLS] = :color_default
      @style[Scintilla::SCE_HJ_STRINGEOL] = :color_default
      @style[Scintilla::SCE_HJ_REGEX] = :color_default
      @style[Scintilla::SCE_HJA_START] = :color_default
      @style[Scintilla::SCE_HJA_DEFAULT] = :color_default
      @style[Scintilla::SCE_HJA_COMMENT] = :color_comment
      @style[Scintilla::SCE_HJA_COMMENTLINE] = :color_comment
      @style[Scintilla::SCE_HJA_COMMENTDOC] = :color_comment
      @style[Scintilla::SCE_HJA_NUMBER] = :color_default
      @style[Scintilla::SCE_HJA_WORD] = :color_default
      @style[Scintilla::SCE_HJA_KEYWORD] = :color_default
      @style[Scintilla::SCE_HJA_DOUBLESTRING] = :color_default
      @style[Scintilla::SCE_HJA_SINGLESTRING] = :color_default
      @style[Scintilla::SCE_HJA_SYMBOLS] = :color_default
      @style[Scintilla::SCE_HJA_STRINGEOL] = :color_default
      @style[Scintilla::SCE_HJA_REGEX] = :color_default
      @style[Scintilla::SCE_HB_START] = :color_default
      @style[Scintilla::SCE_HB_DEFAULT] = :color_default
      @style[Scintilla::SCE_HB_COMMENTLINE] = :color_comment
      @style[Scintilla::SCE_HB_NUMBER] = :color_default
      @style[Scintilla::SCE_HB_WORD] = :color_default
      @style[Scintilla::SCE_HB_STRING] = :color_default
      @style[Scintilla::SCE_HB_IDENTIFIER] = :color_default
      @style[Scintilla::SCE_HB_STRINGEOL] = :color_default
      @style[Scintilla::SCE_HBA_START] = :color_default
      @style[Scintilla::SCE_HBA_DEFAULT] = :color_default
      @style[Scintilla::SCE_HBA_COMMENTLINE] = :color_comment
      @style[Scintilla::SCE_HBA_NUMBER] = :color_default
      @style[Scintilla::SCE_HBA_WORD] = :color_default
      @style[Scintilla::SCE_HBA_STRING] = :color_default
      @style[Scintilla::SCE_HBA_IDENTIFIER] = :color_default
      @style[Scintilla::SCE_HBA_STRINGEOL] = :color_default
      @style[Scintilla::SCE_HP_START] = :color_default
      @style[Scintilla::SCE_HP_DEFAULT] = :color_default
      @style[Scintilla::SCE_HP_COMMENTLINE] = :color_comment
      @style[Scintilla::SCE_HP_NUMBER] = :color_default
      @style[Scintilla::SCE_HP_STRING] = :color_default
      @style[Scintilla::SCE_HP_CHARACTER] = :color_default
      @style[Scintilla::SCE_HP_WORD] = :color_default
      @style[Scintilla::SCE_HP_TRIPLE] = :color_default
      @style[Scintilla::SCE_HP_TRIPLEDOUBLE] = :color_default
      @style[Scintilla::SCE_HP_CLASSNAME] = :color_default
      @style[Scintilla::SCE_HP_DEFNAME] = :color_default
      @style[Scintilla::SCE_HP_OPERATOR] = :color_default
      @style[Scintilla::SCE_HP_IDENTIFIER] = :color_default
      @style[Scintilla::SCE_HPHP_COMPLEX_VARIABLE] = :color_default
      @style[Scintilla::SCE_HPA_START] = :color_default
      @style[Scintilla::SCE_HPA_DEFAULT] = :color_default
      @style[Scintilla::SCE_HPA_COMMENTLINE] = :color_comment
      @style[Scintilla::SCE_HPA_NUMBER] = :color_default
      @style[Scintilla::SCE_HPA_STRING] = :color_default
      @style[Scintilla::SCE_HPA_CHARACTER] = :color_default
      @style[Scintilla::SCE_HPA_WORD] = :color_default
      @style[Scintilla::SCE_HPA_TRIPLE] = :color_default
      @style[Scintilla::SCE_HPA_TRIPLEDOUBLE] = :color_default
      @style[Scintilla::SCE_HPA_CLASSNAME] = :color_default
      @style[Scintilla::SCE_HPA_DEFNAME] = :color_default
      @style[Scintilla::SCE_HPA_OPERATOR] = :color_default
      @style[Scintilla::SCE_HPA_IDENTIFIER] = :color_default
      @style[Scintilla::SCE_HPHP_DEFAULT] = :color_default
      @style[Scintilla::SCE_HPHP_HSTRING] = :color_default
      @style[Scintilla::SCE_HPHP_SIMPLESTRING] = :color_default
      @style[Scintilla::SCE_HPHP_WORD] = :color_default
      @style[Scintilla::SCE_HPHP_NUMBER] = :color_default
      @style[Scintilla::SCE_HPHP_VARIABLE] = :color_default
      @style[Scintilla::SCE_HPHP_COMMENT] = :color_comment
      @style[Scintilla::SCE_HPHP_COMMENTLINE] = :color_comment
      @style[Scintilla::SCE_HPHP_HSTRING_VARIABLE] = :color_default
      @style[Scintilla::SCE_HPHP_OPERATOR] = :color_default
    end

    def set_style(view_win, theme)
      super
      view_win.sci_set_property('fold.html', '1')
    end

    def end_of_block?(line)
      if line =~ %r{^\s*</.*>\s*$}
        true
      else
        false
      end
    end
  end
end
