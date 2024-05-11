module Mrbmacs
  class RMode < Mode
    def initialize
      super
      @name = 'r'
      @lexer = 'r'
      @keyword_list = 'if else repeat while function for in next break TRUE FALSE NULL NA Inf NaN'
      @start_of_comment = '# '

      @style[Scintilla::SCE_R_DEFAULT] = :color_default
      @style[Scintilla::SCE_R_COMMENT] = :color_comment
      @style[Scintilla::SCE_R_KWORD] = :color_builtin
      @style[Scintilla::SCE_R_BASEKWORD] = :color_keyword
      @style[Scintilla::SCE_R_OTHERKWORD] = :color_keyword
      @style[Scintilla::SCE_R_NUMBER] = :color_default
      @style[Scintilla::SCE_R_STRING] = :color_string
      @style[Scintilla::SCE_R_STRING2] = :color_string
      @style[Scintilla::SCE_R_OPERATOR] = :color_default
      @style[Scintilla::SCE_R_IDENTIFIER] = :color_default
      @style[Scintilla::SCE_R_INFIX] = :color_default
      @style[Scintilla::SCE_R_INFIXEOL] = :color_default
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
