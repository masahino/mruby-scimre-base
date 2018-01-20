module Mrbmacs
    include Scintilla
  class PythonMode < Mode
    def initialize
      super.initialize
      @indent = 4
      @name = "python"
      @lexer = "python"
      @use_tabs = false
      @keyword_list = "and as assert break class continue def del elif else except exec finally for from global if import in is lambda not or pass print raise return try while with yield"
      @style = [
        :color_foreground, # SCE_P_DEFAULT 0
        :color_comment, # SCE_P_COMMENT 1
        :color_foreground, # SCE_P_NUMBER 2
        :color_string, # SCE_P_STRING 3
        :color_string, # SCE_P_CHARACTER 4
        :color_keyword, # SCE_P_WORD 5
        :color_foreground, # SCE_P_TRIPLE 6
        :color_foreground, # SCE_P_TRIPLEDOUBLE 7
        :color_type, # SCE_P_CLASSNAME 8
        :color_function_name, # SCE_P_DEFNAME 9
        :color_foreground, # SCE_P_OPERATOR 10
        :color_keyword, # SCE_P_IDENTIFIER 11
        :color_comment, # SCE_P_COMMENTBLOCK 12
        :color_foreground, # SCE_P_STRINGEOL 13
        :color_keyword, # SCE_P_WORD2 14
        :color_foreground, # SCE_P_DECORATOR 15
        :color_string, # SCE_P_FSTRING 16
        :color_foreground, # SCE_P_FCHARACTER 17
        :color_foreground, # SCE_P_FTRIPLE 18
        :color_foreground, # SCE_P_FTRIPLEDOUBLE 19
        ]
    end
    def get_indent_level(view_win)
      line = view_win.sci_line_from_position(view_win.sci_get_current_pos())
      level = view_win.sci_get_fold_level(line) & Scintilla::SC_FOLDLEVELNUMBERMASK - Scintilla::SC_FOLDLEVELBASE
      cur_line = view_win.sci_get_curline()[0]
      if level > 0 and cur_line =~/^\s+}.*$/
        level -= 1
      end
      return level
    end

    def get_completion_list(view_win)
      pos = view_win.sci_get_current_pos()
      col = view_win.sci_get_column(pos)
      if col > 0
        line = view_win.sci_line_from_position(pos)
        line_text = view_win.sci_get_line(line).chomp[0..col]
        input = line_text.split(" ").pop
        if input != nil and input.length > 0
          [input.length, @keyword_list]
        else
          [0, []]
        end
      else
        [0, []]
      end
    end

  end
end
