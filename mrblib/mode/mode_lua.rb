module Mrbmacs
  class LuaMode < Mode
    def initialize
      super.initialize
      @name = 'lua'
      @lexer = 'lua'
      @keyword_list = ''
      @start_of_comment = '# '
      @style = [
        :color_foreground, # define SCE_LUA_DEFAULT 0
        :color_comment, # define SCE_LUA_COMMENT 1
        :color_comment, # define SCE_LUA_COMMENTLINE 2
        :color_comment, # define SCE_LUA_COMMENTDOC 3
        :color_foreground, # define SCE_LUA_NUMBER 4
        :color_keyword, # define SCE_LUA_WORD 5
        :color_string, # define SCE_LUA_STRING 6
        :color_foreground, # define SCE_LUA_CHARACTER 7
        :color_string, # define SCE_LUA_LITERALSTRING 8
        :color_preprocessor, # define SCE_LUA_PREPROCESSOR 9
        :color_foreground, # define SCE_LUA_OPERATOR 10
        :color_foreground, # define SCE_LUA_IDENTIFIER 11
        :color_string, # define SCE_LUA_STRINGEOL 12
        :color_keyword, # define SCE_LUA_WORD2 13
        :color_keyword, # define SCE_LUA_WORD3 14
        :color_keyword, # define SCE_LUA_WORD4 15
        :color_keyword, # define SCE_LUA_WORD5 16
        :color_keyword, # define SCE_LUA_WORD6 17
        :color_keyword, # define SCE_LUA_WORD7 18
        :color_keyword, # define SCE_LUA_WORD8 19
        :color_keyword # define SCE_LUA_LABEL 20
      ]
    end

    def set_style(view_win, theme)
      super
      view_win.sci_set_property('fold.compact', '1')
    end

    def end_of_block?(line)
      if line =~ /^\s*(end|else}).*$/
        true
      else
        false
      end
    end
  end
end
