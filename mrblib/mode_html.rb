module Mrbmacs
  class HtmlMode < Mode
    include Scintilla
    def initialize
      super.initialize
      @name = "html"
      @keyword_list = ""
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
