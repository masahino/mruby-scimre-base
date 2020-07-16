module Mrbmacs
  class Config
    attr_accessor :theme
    attr_accessor :ext
    attr_accessor :use_builtin_completion, :use_builtin_indent
    def initialize
      @use_builtin_completion = false
      @use_builtin_indent = false
      @theme = SolarizedDarkTheme
      @ext = {}
    end
  end
end