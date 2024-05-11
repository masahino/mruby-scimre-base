module Mrbmacs
  class MarkdownMode < Mode
    def initialize
      super
      @name = 'markdown'
      @lexer = 'markdown'

      @style[Scintilla::SCE_MARKDOWN_DEFAULT] = :color_default
      @style[Scintilla::SCE_MARKDOWN_LINE_BEGIN] = :color_default
      @style[Scintilla::SCE_MARKDOWN_STRONG1] = :color_string
      @style[Scintilla::SCE_MARKDOWN_STRONG2] = :color_string
      @style[Scintilla::SCE_MARKDOWN_EM1] = :color_string
      @style[Scintilla::SCE_MARKDOWN_EM2] = :color_string
      @style[Scintilla::SCE_MARKDOWN_HEADER1] = :color_keyword
      @style[Scintilla::SCE_MARKDOWN_HEADER2] = :color_keyword
      @style[Scintilla::SCE_MARKDOWN_HEADER3] = :color_keyword
      @style[Scintilla::SCE_MARKDOWN_HEADER4] = :color_keyword
      @style[Scintilla::SCE_MARKDOWN_HEADER5] = :color_keyword
      @style[Scintilla::SCE_MARKDOWN_HEADER6] = :color_keyword
      @style[Scintilla::SCE_MARKDOWN_PRECHAR] = :color_keyword
      @style[Scintilla::SCE_MARKDOWN_ULIST_ITEM] = :color_type
      @style[Scintilla::SCE_MARKDOWN_OLIST_ITEM] = :color_keyword
      @style[Scintilla::SCE_MARKDOWN_BLOCKQUOTE] = :color_string
      @style[Scintilla::SCE_MARKDOWN_STRIKEOUT] = :color_default
      @style[Scintilla::SCE_MARKDOWN_HRULE] = :color_default
      @style[Scintilla::SCE_MARKDOWN_LINK] = :color_default
      @style[Scintilla::SCE_MARKDOWN_CODE] = :color_default
      @style[Scintilla::SCE_MARKDOWN_CODE2] = :color_default
      @style[Scintilla::SCE_MARKDOWN_CODEBK] = :color_other_emphasized
    end
  end
end
