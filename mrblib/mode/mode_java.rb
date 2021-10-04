module Mrbmacs
  include Scintilla
  class JavaMode < CppMode
    def initialize
      super
      @name = 'java'
    end
  end
end
