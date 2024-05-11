module Mrbmacs
  class RustMode < Mode
    def initialize
      super
      @name = 'rust'
      @lexer = 'rust'
      @indent = 4
      @keyword_list = "as fn let const static if else match for in loop \
      while break continue return crate extern use mod self super struct \
      enum union trait type where impl Self self pub unsafe true false \
      move mut ref box do catch default"
      @start_of_comment = '// '
      @build_command = 'cargo build'

      @style[Scintilla::SCE_RUST_DEFAULT] = :color_default
      @style[Scintilla::SCE_RUST_COMMENTBLOCK] = :color_comment
      @style[Scintilla::SCE_RUST_COMMENTLINE] = :color_comment
      @style[Scintilla::SCE_RUST_COMMENTBLOCKDOC] = :color_comment
      @style[Scintilla::SCE_RUST_COMMENTLINEDOC] = :color_comment
      @style[Scintilla::SCE_RUST_NUMBER] = :color_default
      @style[Scintilla::SCE_RUST_WORD] = :color_keyword
      @style[Scintilla::SCE_RUST_WORD2] = :color_keyword
      @style[Scintilla::SCE_RUST_WORD3] = :color_keyword
      @style[Scintilla::SCE_RUST_WORD4] = :color_keyword
      @style[Scintilla::SCE_RUST_WORD5] = :color_keyword
      @style[Scintilla::SCE_RUST_WORD6] = :color_keyword
      @style[Scintilla::SCE_RUST_WORD7] = :color_keyword
      @style[Scintilla::SCE_RUST_STRING] = :color_string
      @style[Scintilla::SCE_RUST_STRINGR] = :color_string
      @style[Scintilla::SCE_RUST_CHARACTER] = :color_default
      @style[Scintilla::SCE_RUST_OPERATOR] = :color_default
      @style[Scintilla::SCE_RUST_IDENTIFIER] = :color_default
      @style[Scintilla::SCE_RUST_LIFETIME] = :color_variable_name
      @style[Scintilla::SCE_RUST_MACRO] = :color_builtin
      @style[Scintilla::SCE_RUST_LEXERROR] = :color_warning
      @style[Scintilla::SCE_RUST_BYTESTRING] = :color_default
      @style[Scintilla::SCE_RUST_BYTESTRINGR] = :color_default
      @style[Scintilla::SCE_RUST_BYTECHARACTER] = :color_default
    end

    def set_style(view_win, theme)
      super
      view_win.sci_set_property('fold.compact', '1')
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
