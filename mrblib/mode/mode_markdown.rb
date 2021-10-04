module Mrbmacs
  class MarkdownMode < Mode
    include Scintilla
    def initialize
      super.initialize
      @name = 'markdown'
      @lexer = 'markdown'
      @style = [
        :color_foreground, # SCE_MARKDOWN_DEFAULT 0
        :color_foreground, # SCE_MARKDOWN_LINE_BEGIN 1
        :color_string, # SCE_MARKDOWN_STRONG1 2
        :color_string, # SCE_MARKDOWN_STRONG2 3
        :color_string, # SCE_MARKDOWN_EM1 4
        :color_string, # SCE_MARKDOWN_EM2 5
        :color_keyword, # SCE_MARKDOWN_HEADER1 6
        :color_keyword, # SCE_MARKDOWN_HEADER2 7
        :color_keyword, # SCE_MARKDOWN_HEADER3 8
        :color_keyword, # SCE_MARKDOWN_HEADER4 9
        :color_keyword, # SCE_MARKDOWN_HEADER5 10
        :color_keyword, # SCE_MARKDOWN_HEADER6 11
        :color_keyword, # SCE_MARKDOWN_PRECHAR 12
        :color_type,    # SCE_MARKDOWN_ULIST_ITEM 13
        :color_keyword, # SCE_MARKDOWN_OLIST_ITEM 14
        :color_string,  # SCE_MARKDOWN_BLOCKQUOTE 15
        :color_foreground, # SCE_MARKDOWN_STRIKEOUT 16
        :color_foreground, # SCE_MARKDOWN_HRULE 17
        :color_foreground, # SCE_MARKDOWN_LINK 18
        :color_foreground, # SCE_MARKDOWN_CODE 19
        :color_foreground, # SCE_MARKDOWN_CODE2 20
        :color_other_emphasized # SCE_MARKDOWN_CODEBK 21},
      ]
    end
  end
end
