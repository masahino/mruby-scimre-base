module Mrbmacs
  class BashMode < Mode
    include Scintilla
    def initialize
      super.initialize
      @name = "bash"
      @keyword_list = ""
      @style = [
        :color_foreground, #define SCE_SH_DEFAULT 0
        :color_warning, #define SCE_SH_ERROR 1
        :color_comment, #define SCE_SH_COMMENTLINE 2
        :color_foreground, #define SCE_SH_NUMBER 3
        :color_keyword, #define SCE_SH_WORD 4
        :color_string, #define SCE_SH_STRING 5
        :color_foreground, #define SCE_SH_CHARACTER 6
        :color_foreground, #define SCE_SH_OPERATOR 7
        :color_foreground, #define SCE_SH_IDENTIFIER 8
        :color_foreground, #define SCE_SH_SCALAR 9
        :color_foreground, #define SCE_SH_PARAM 10
        :color_foreground, #define SCE_SH_BACKTICKS 11
        :color_foreground, #define SCE_SH_HERE_DELIM 12
        :color_foreground, #define SCE_SH_HERE_Q 13
          ]
    end

    def get_indent_level(view_win)
      line = view_win.sci_line_from_position(view_win.sci_get_current_pos())
      level = view_win.sci_get_fold_level(line) & Scintilla::SC_FOLDLEVELNUMBERMASK - Scintilla::SC_FOLDLEVELBASE
      cur_line = view_win.sci_get_curline()[0]
      if $DEBUG
        $stderr.puts "level = #{level}"
      end
      if level > 0 and cur_line =~/^\s+}.*$/
        level -= 1
      end
      return level
    end
  end
end
