module Mrbmacs
  class RustMode < Mode
    include Scintilla
    def initialize
      super.initialize
      @name = 'rust'
      @lexer = 'rust'
      @indent = 4
      @keyword_list = "as fn let const static if else match for in loop \
      while break continue return crate extern use mod self super struct \
      enum union trait type where impl Self self pub unsafe true false \
      move mut ref box do catch default"
      @start_of_comment = '// '
      @build_command = 'cargo build'
      @style = [
        :color_foreground, # define SCE_RUST_DEFAULT 0
        :color_comment, # define SCE_RUST_COMMENTBLOCK 1
        :color_comment, # define SCE_RUST_COMMENTLINE 2
        :color_comment, # define SCE_RUST_COMMENTBLOCKDOC 3
        :color_comment, # define SCE_RUST_COMMENTLINEDOC 4
        :color_foreground, # #define SCE_RUST_NUMBER 5
        :color_keyword, # define SCE_RUST_WORD 6
        :color_keyword, # define SCE_RUST_WORD2 7
        :color_keyword, # define SCE_RUST_WORD3 8
        :color_keyword, # define SCE_RUST_WORD4 9
        :color_keyword, # define SCE_RUST_WORD5 10
        :color_keyword, # define SCE_RUST_WORD6 11
        :color_keyword, # define SCE_RUST_WORD7 12
        :color_string, # define SCE_RUST_STRING 13
        :color_string, # define SCE_RUST_STRINGR 14
        :color_foreground, # define SCE_RUST_CHARACTER 15
        :color_foreground, # define SCE_RUST_OPERATOR 16
        :color_foreground, # define SCE_RUST_IDENTIFIER 17
        :color_variable_name, # define SCE_RUST_LIFETIME 18
        :color_builtin, # define SCE_RUST_MACRO 19
        :color_warning, # define SCE_RUST_LEXERROR 20
        :color_foreground, # define SCE_RUST_BYTESTRING 21
        :color_foreground, # define SCE_RUST_BYTESTRINGR 22
        :color_foreground # define SCE_RUST_BYTECHARACTER 23
      ]
    end

    def set_style(view_win, theme)
      super
      view_win.sci_set_property('fold.compact', '1')
    end

    def is_end_of_block(line)
      if line =~ /^\s*}.*$/
        true
      else
        false
      end
    end
  end
end
