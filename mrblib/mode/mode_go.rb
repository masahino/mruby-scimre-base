module Mrbmacs
  class GoMode < Mode
    def initialize
      super
      @indent = 4
      @name = 'go'
      @lexer = 'cpp'
      @use_tabs = true
      @tab_indent = 8
      @keyword_list = 'break default func interface select case defer go map struct chan else goto package switch const fallthrough if range type continue for import return var bool int int8 int16 int32 int64 byte uint uint8 uint16 uint32 uint64 uintptr float float32 float64 string nil true false'
      @start_of_comment = '// '

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

    def get_indent_level(view_win)
      line = view_win.sci_line_from_position(view_win.sci_get_current_pos)
      level = view_win.sci_get_fold_level(line) & Scintilla::SC_FOLDLEVELNUMBERMASK - Scintilla::SC_FOLDLEVELBASE
      cur_line = view_win.sci_get_curline()[0]
      if level > 0 && cur_line =~ /^\s+}.*$/
        level -= 1
      end
      return level
    end
  end
end
