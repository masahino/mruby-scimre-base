module Mrbmacs
  class JsonMode < Mode
    def initialize
      super.initialize
      @name = 'json'
      @lexer = 'json'
      @style = [
        :color_foreground, # define SCE_JSON_DEFAULT 0
        :color_constant, # define SCE_JSON_NUMBER 1
        :color_string, # define SCE_JSON_STRING 2
        :color_string, # define SCE_JSON_STRINGEOL 3
        :color_function_name, # define SCE_JSON_PROPERTYNAME 4
        :color_string, # define SCE_JSON_ESCAPESEQUENCE 5
        :color_comment, # #define SCE_JSON_LINECOMMENT 6
        :color_comment, # #define SCE_JSON_BLOCKCOMMENT 7
        :color_foreground, # define SCE_JSON_OPERATOR 8
        :color_constant, # define SCE_JSON_URI 9
        :color_constant, # define SCE_JSON_COMPACTIRI 10
        :color_keyword, # define SCE_JSON_KEYWORD 11
        :color_keyword, # define SCE_JSON_LDKEYWORD 12
        :color_warning # define SCE_JSON_ERROR 13
      ]
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
