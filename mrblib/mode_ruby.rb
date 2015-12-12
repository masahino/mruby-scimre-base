module Scimre
  class RubyMode < Mode
    def initialize
      super.initialize
    @name = "ruby"
    @keyword_list = "attr_accessor attr_reader attr_writer module_function begin break elsif module retry unless end case next return until class ensure nil self when def false not super while alias defined? for or then yield and do if redo true else in rescue undef"
    end
    
    def get_indent_level(view_win)
      line = view_win.sci_line_from_position(view_win.sci_get_current_pos())
      $stderr.puts "line = #{line}"
      level = view_win.sci_get_fold_level(line) & Scintilla::SC_FOLDLEVELNUMBERMASK - Scintilla::SC_FOLDLEVELBASE
      $stderr.puts "level = #{view_win.sci_get_fold_level(line)}"
      cur_line = view_win.sci_get_curline()[0]
      if level > 0 and cur_line =~/^\s+(end|else|then|elsif|when|rescue|ensure|}).*$/
        level -= 1
      end
      return level
    end
  end
end
