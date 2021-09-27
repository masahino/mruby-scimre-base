module Mrbmacs
  class Config
    attr_accessor :theme
    attr_accessor :ext
    attr_accessor :use_builtin_completion, :use_builtin_indent, :use_builtin_syntax_check
    def initialize
      @use_builtin_completion = false
      @use_builtin_indent = false
      @use_builtin_syntax_check = false
      @theme = SolarizedDarkTheme
      @ext = {}
    end
  end
end
