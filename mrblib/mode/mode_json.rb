module Mrbmacs
  class JsonMode < Mode
    def initialize
      super
      @name = 'json'
      @lexer = 'json'

      @style[Scintilla::SCE_JSON_DEFAULT] = :color_default
      @style[Scintilla::SCE_JSON_NUMBER] = :color_constant
      @style[Scintilla::SCE_JSON_STRING] = :color_string
      @style[Scintilla::SCE_JSON_STRINGEOL] = :color_string
      @style[Scintilla::SCE_JSON_PROPERTYNAME] = :color_function_name
      @style[Scintilla::SCE_JSON_ESCAPESEQUENCE] = :color_string
      @style[Scintilla::SCE_JSON_LINECOMMENT] = :color_comment
      @style[Scintilla::SCE_JSON_BLOCKCOMMENT] = :color_comment
      @style[Scintilla::SCE_JSON_OPERATOR] = :color_default
      @style[Scintilla::SCE_JSON_URI] = :color_constant
      @style[Scintilla::SCE_JSON_COMPACTIRI] = :color_constant
      @style[Scintilla::SCE_JSON_KEYWORD] = :color_keyword
      @style[Scintilla::SCE_JSON_LDKEYWORD] = :color_keyword
      @style[Scintilla::SCE_JSON_ERROR] = :color_warning
    end

    def end_of_block?(line)
      if line =~ /^\s*(\]|}).*$/
        true
      else
        false
      end
    end
  end
end
