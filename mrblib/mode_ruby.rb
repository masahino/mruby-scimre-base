module Mrbmacs
  class RubyMode < Mode
    def initialize
      super.initialize
    @name = "ruby"
    @keyword_list = "attr_accessor attr_reader attr_writer module_function begin break elsif module retry unless end case next return until class ensure nil self when def false not super while alias defined? for or then yield and do if redo true else in rescue undef"
      @style = [
        :color_foreground, # SCE_RB_DEFAULT 0
        :color_warning, # SCE_RB_ERROR 1
        :color_comment, # SCE_RB_COMMENTLINE 2
        :color_comment, # SCE_RB_POD 3
        :color_foreground, # SCE_RB_NUMBER 4
        :color_keyword, # SCE_RB_WORD 5
        :color_string, # SCE_RB_STRING 6
        :color_string, # SCE_RB_CHARACTER 7
        :color_type, # SCE_RB_CLASSNAME 8
        :color_function_name, # SCE_RB_DEFNAME 9
        :color_foreground, # SCE_RB_OPERATOR 10
        :color_foreground, # SCE_RB_IDENTIFIER 11
        :color_regexp_grouping_construct, # SCE_RB_REGEX 12
        :color_variable_name, # SCE_RB_GLOBAL 13
        :color_string, # SCE_RB_SYMBOL 14
        :color_preprocessor, # SCE_RB_MODULE_NAME 15
        :color_variable_name, # SCE_RB_INSTANCE_VAR 16
        :color_variable_name, # SCE_RB_CLASS_VAR 17
        :color_negation_char, # SCE_RB_BACKTICKS 18
        :color_foreground, # SCE_RB_DATASECTION 19
        :color_foreground, # SCE_RB_HERE_DELIM 20
        :color_foreground, # SCE_RB_HERE_Q 21
        :color_foreground, # SCE_RB_HERE_QQ 22
        :color_foreground, # SCE_RB_HERE_QX 23
        :color_foreground, # SCE_RB_STRING_Q 24
        :color_foreground, # SCE_RB_STRING_QQ 25
        :color_foreground, # SCE_RB_STRING_QX 26
        :color_foreground, # SCE_RB_STRING_QR 27
        :color_foreground, # SCE_RB_STRING_QW 28
        :color_foreground, # SCE_RB_WORD_DEMOTED 29
        :color_foreground, # SCE_RB_STDIN 30
        :color_foreground, # SCE_RB_STDOUT 31
#        :color_foreground, # 32
#        :color_foreground, # 33
#        :color_foreground, # 34
#        :color_foreground, # 35
#        :color_foreground, # 36
#        :color_foreground, # 37
#        :color_foreground, # 38
#        :color_foreground, # 39
#        :color_foreground, # SCE_RB_STDERR 40
#        :color_foreground, # SCE_RB_UPPER_BOUND 41
        ]
    end
    
    def get_indent_level(view_win)
      line = view_win.sci_line_from_position(view_win.sci_get_current_pos())
      level = view_win.sci_get_fold_level(line) & Scintilla::SC_FOLDLEVELNUMBERMASK - Scintilla::SC_FOLDLEVELBASE
      cur_line = view_win.sci_get_curline()[0]
      if level > 0 and cur_line =~/^\s+(end|else|then|elsif|when|rescue|ensure|}).*$/
        level -= 1
      end
      return level
    end

    def syntax_check(view_win)
      all_text = view_win.sci_get_text(view_win.sci_get_length+1)
      Mrbmacs::mrb_check_syntax(all_text)
    end
  end
end
