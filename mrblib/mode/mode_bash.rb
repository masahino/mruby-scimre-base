module Mrbmacs
  # Bash mode
  class BashMode < Mode
    def initialize
      super
      @name = 'bash'
      @lexer = 'bash'
      @keyword_list = ''
      @start_of_comment = '# '
      @style[Scintilla::SCE_SH_DEFAULT] = :color_default
      @style[Scintilla::SCE_SH_ERROR] = :color_warning
      @style[Scintilla::SCE_SH_COMMENTLINE] = :color_comment
      @style[Scintilla::SCE_SH_NUMBER] = :color_default
      @style[Scintilla::SCE_SH_WORD] = :color_keyword
      @style[Scintilla::SCE_SH_STRING] = :color_string
      @style[Scintilla::SCE_SH_CHARACTER] = :color_default
      @style[Scintilla::SCE_SH_OPERATOR] = :color_default
      @style[Scintilla::SCE_SH_IDENTIFIER] = :color_default
      @style[Scintilla::SCE_SH_SCALAR] = :color_default
      @style[Scintilla::SCE_SH_PARAM] = :color_default
      @style[Scintilla::SCE_SH_BACKTICKS] = :color_default
      @style[Scintilla::SCE_SH_HERE_DELIM] = :color_default
      @style[Scintilla::SCE_SH_HERE_Q] = :color_default
    end

    def set_style(view_win, theme)
      super
      view_win.sci_set_property('fold.compact', '1')
    end

    def end_of_block?(line)
      if line =~ /^\s*(end|else|fi|done|}).*$/
        true
      else
        false
      end
    end
  end
end
