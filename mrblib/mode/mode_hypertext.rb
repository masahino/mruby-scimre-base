module Mrbmacs
  class HtmlMode < Mode
    include Scintilla
    def initialize
      super.initialize
      @name = 'html'
      @lexer = 'hypertext'
      @keyword_list = ''
      @start_of_comment = '<!-- '
      @end_of_comment = ' -->'
      @style = [
        :color_foreground, # define SCE_H_DEFAULT 0
        :color_keyword, # define SCE_H_TAG 1
        :color_warning, # define SCE_H_TAGUNKNOWN 2
        :color_variable_name, # define SCE_H_ATTRIBUTE 3
        :color_warning, # define SCE_H_ATTRIBUTEUNKNOWN 4
        :color_foreground, # define SCE_H_NUMBER 5
        :color_string, # define SCE_H_DOUBLESTRING 6
        :color_string, # define SCE_H_SINGLESTRING 7
        :color_foreground, # define SCE_H_OTHER 8
        :color_comment, # define SCE_H_COMMENT 9
        :color_foreground, # define SCE_H_ENTITY 10
        :color_foreground # define SCE_H_TAGEND 11
      ]
    end

    def set_style(view_win, theme)
      super
      view_win.sci_set_property('fold.html', '1')
    end

    def is_end_of_block(line)
      if line =~/^\s*<\/.*>\s*$/
        true
      else
        false
      end
    end
  end
end
