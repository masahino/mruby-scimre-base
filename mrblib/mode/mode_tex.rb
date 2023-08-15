module Mrbmacs
  class LatexMode < Mode
    def initialize
      super.initialize
      @name = 'latex'
      @lexer = 'latex'
      @keyword_list = ''
      @start_of_comment = '% '
      @style = [
        :color_foreground, # define SCE_L_DEFAULT 0
        :color_builtin, # define SCE_L_COMMAND 1
        :color_variable_name, # define SCE_L_TAG 2
        :color_foreground, # define SCE_L_MATH 3
        :color_comment, # define SCE_L_COMMENT 4
        :color_variable_name, # define SCE_L_TAG2 5
        :color_foreground, # define SCE_L_MATH2 6
        :color_comment, # define SCE_L_COMMENT2 7
        :color_foreground, # define SCE_L_VERBATIM 8
        :color_foreground, # define SCE_L_SHORTCMD 9
        :color_foreground, # define SCE_L_SPECIAL 10
        :color_foreground, # define SCE_L_CMDOPT 11
        :color_warning # define SCE_L_ERROR 12
      ]
    end

    def set_style(view_win, theme)
      super
      view_win.sci_set_property('fold.compact', '1')
    end
  end
end
