module Mrbmacs
  class CppMode < Mode
    def initialize
      super
      @name = 'cpp'
      @lexer = 'cpp'
      @keyword_list = 'and and_eq asm auto bitand bitor bool break case catch char class compl const const_cast constexpr continue default delete do double dynamic_cast else enum explicit export extern false float for friend goto if inline int long mutable namespace new not not_eq operator or or_eq private protected public register reinterpret_cast return short signed sizeof static static_cast struct switch template this throw true try typedef typeid typename union unsigned using virtual void volatile wchar_t while xor xor_eq'
      @start_of_comment = '/* '
      @end_of_comment = ' */'
      @style[Scintilla::SCE_C_DEFAULT] = :color_default
      @style[Scintilla::SCE_C_COMMENT] = :color_comment
      @style[Scintilla::SCE_C_COMMENTLINE] = :color_comment
      @style[Scintilla::SCE_C_COMMENTDOC] = :color_comment
      @style[Scintilla::SCE_C_NUMBER] = :color_default
      @style[Scintilla::SCE_C_WORD] = :color_keyword
      @style[Scintilla::SCE_C_STRING] = :color_string
      @style[Scintilla::SCE_C_CHARACTER] = :color_default
      @style[Scintilla::SCE_C_UUID] = :color_default
      @style[Scintilla::SCE_C_PREPROCESSOR] = :color_preprocessor
      @style[Scintilla::SCE_C_OPERATOR] = :color_default
      @style[Scintilla::SCE_C_IDENTIFIER] = :color_default
      @style[Scintilla::SCE_C_STRINGEOL] = :color_string
      @style[Scintilla::SCE_C_VERBATIM] = :color_default
      @style[Scintilla::SCE_C_REGEX] = :color_regexp_grouping_construct
      @style[Scintilla::SCE_C_COMMENTLINEDOC] = :color_comment
      @style[Scintilla::SCE_C_WORD2] = :color_keyword
      @style[Scintilla::SCE_C_COMMENTDOCKEYWORD] = :color_comment
      @style[Scintilla::SCE_C_COMMENTDOCKEYWORDERROR] = :color_comment
      @style[Scintilla::SCE_C_GLOBALCLASS] = :color_default
      @style[Scintilla::SCE_C_STRINGRAW] = :color_string
      @style[Scintilla::SCE_C_TRIPLEVERBATIM] = :color_default
      @style[Scintilla::SCE_C_HASHQUOTEDSTRING] = :color_string
      @style[Scintilla::SCE_C_PREPROCESSORCOMMENT] = :color_comment
      @style[Scintilla::SCE_C_PREPROCESSORCOMMENTDOC] = :color_comment
      @style[Scintilla::SCE_C_USERLITERAL] = :color_default
      @style[Scintilla::SCE_C_TASKMARKER] = :color_default
      @style[Scintilla::SCE_C_ESCAPESEQUENCE] = :color_negation_char
    end

    def set_style(view_win, theme)
      super
      view_win.sci_set_property('lexer.cpp.track.preprocessor', '0')
    end

    def end_of_block?(line)
      if line =~ /^\s*}.*$/
        true
      else
        false
      end
    end
  end
end
