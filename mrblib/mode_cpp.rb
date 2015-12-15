module Mrbmacs
    include Scintilla
  class CppMode < Mode
    def initialize
      super.initialize
      @name = "cpp"
      @keyword_list = "and and_eq asm auto bitand bitor bool break case catch char class compl const const_cast constexpr continue default delete do double dynamic_cast else enum explicit export extern false float for friend goto if inline int long mutable namespace new not not_eq operator or or_eq private protected public register reinterpret_cast return short signed sizeof static static_cast struct switch template this throw true try typedef typeid typename union unsigned using virtual void volatile wchar_t while xor xor_eq"
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
  end
end
