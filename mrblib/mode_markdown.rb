module Scimre
  class MarkdownMode < Mode
    include Scintilla
    def initialize
      super.initialize
      @name = "markdown"
    end
  end
end
