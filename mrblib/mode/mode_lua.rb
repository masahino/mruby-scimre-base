module Mrbmacs
  class LuaMode < Mode
    def initialize
      super
      @name = 'lua'
      @lexer = 'lua'
      @keyword_list = ''
      @start_of_comment = '# '

      @style[Scintilla::SCE_LUA_DEFAULT] = :color_default
      @style[Scintilla::SCE_LUA_COMMENT] = :color_comment
      @style[Scintilla::SCE_LUA_COMMENTLINE] = :color_comment
      @style[Scintilla::SCE_LUA_COMMENTDOC] = :color_comment
      @style[Scintilla::SCE_LUA_NUMBER] = :color_default
      @style[Scintilla::SCE_LUA_WORD] = :color_keyword
      @style[Scintilla::SCE_LUA_STRING] = :color_string
      @style[Scintilla::SCE_LUA_CHARACTER] = :color_default
      @style[Scintilla::SCE_LUA_LITERALSTRING] = :color_string
      @style[Scintilla::SCE_LUA_PREPROCESSOR] = :color_preprocessor
      @style[Scintilla::SCE_LUA_OPERATOR] = :color_default
      @style[Scintilla::SCE_LUA_IDENTIFIER] = :color_default
      @style[Scintilla::SCE_LUA_STRINGEOL] = :color_string
      @style[Scintilla::SCE_LUA_WORD2] = :color_keyword
      @style[Scintilla::SCE_LUA_WORD3] = :color_keyword
      @style[Scintilla::SCE_LUA_WORD4] = :color_keyword
      @style[Scintilla::SCE_LUA_WORD5] = :color_keyword
      @style[Scintilla::SCE_LUA_WORD6] = :color_keyword
      @style[Scintilla::SCE_LUA_WORD7] = :color_keyword
      @style[Scintilla::SCE_LUA_WORD8] = :color_keyword
      @style[Scintilla::SCE_LUA_LABEL] = :color_keyword
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
