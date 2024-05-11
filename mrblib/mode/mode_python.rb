module Mrbmacs
  class PythonMode < Mode
    def initialize
      super
      @indent = 4
      @name = 'python'
      @lexer = 'python'
      @use_tabs = false
      @keyword_list = "and as assert break class continue def del elif else except exec finally for from \
      global if import in is lambda not or pass print raise return try while with yield"
      @start_of_comment = '# '

      @style[Scintilla::SCE_P_DEFAULT] = :color_default
      @style[Scintilla::SCE_P_COMMENT] = :color_comment
      @style[Scintilla::SCE_P_NUMBER] = :color_default
      @style[Scintilla::SCE_P_STRING] = :color_string
      @style[Scintilla::SCE_P_CHARACTER] = :color_string
      @style[Scintilla::SCE_P_WORD] = :color_keyword
      @style[Scintilla::SCE_P_TRIPLE] = :color_default
      @style[Scintilla::SCE_P_TRIPLEDOUBLE] = :color_default
      @style[Scintilla::SCE_P_CLASSNAME] = :color_type
      @style[Scintilla::SCE_P_DEFNAME] = :color_function_name
      @style[Scintilla::SCE_P_OPERATOR] = :color_default
      @style[Scintilla::SCE_P_IDENTIFIER] = :color_keyword
      @style[Scintilla::SCE_P_COMMENTBLOCK] = :color_comment
      @style[Scintilla::SCE_P_STRINGEOL] = :color_default
      @style[Scintilla::SCE_P_WORD2] = :color_keyword
      @style[Scintilla::SCE_P_DECORATOR] = :color_default
      @style[Scintilla::SCE_P_FSTRING] = :color_string
      @style[Scintilla::SCE_P_FCHARACTER] = :color_default
      @style[Scintilla::SCE_P_FTRIPLE] = :color_default
      @style[Scintilla::SCE_P_FTRIPLEDOUBLE] = :color_default
    end

    def end_of_block?(_line)
      false
    end
  end
end
