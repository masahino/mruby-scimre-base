module Mrbmacs
  class MakeMode < Mode
    def initialize
      super
      @name = 'make'
      @lexer = 'make'
      @keyword_list = ''
      @start_of_comment = '# '
      @style = [
        :color_foreground, # define SCE_MAKE_DEFAULT 0
        :color_comment, # define SCE_MAKE_COMMENT 1
        :color_preprocessor, # define SCE_MAKE_PREPROCESSOR 2
        :color_builtin, # define SCE_MAKE_IDENTIFIER 3
        :color_foreground, # define SCE_MAKE_OPERATOR 4
        :color_function_name, # define SCE_MAKE_TARGET 5
        :color_foreground, # 6
        :color_foreground, # 7
        :color_foreground, # 8
        :color_foreground # define SCE_MAKE_IDEOL 9
      ]
    end

    def set_style(view_win, theme)
      super
      view_win.sci_set_property('fold.compact', '1')
    end
  end
end
