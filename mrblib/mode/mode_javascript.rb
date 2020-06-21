module Mrbmacs
    include Scintilla
  class JavascriptMode < CppMode
    def initialize
      super
      @name = "javascript"
    end

  end
end
