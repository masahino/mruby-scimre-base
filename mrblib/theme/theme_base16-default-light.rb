# Default Light scheme by Chris Kempson (http://chriskempson.com)
module Mrbmacs
  class Base16DefaultLightTheme < Base16Theme
    @@theme_name = 'base16-default-light'
    def initialize
      @@base00 = 0xf8f8f8
      @@base01 = 0xe8e8e8
      @@base02 = 0xd8d8d8
      @@base03 = 0xb8b8b8
      @@base04 = 0x585858
      @@base05 = 0x383838
      @@base06 = 0x282828
      @@base07 = 0x181818
      @@base08 = 0x4246ab
      @@base09 = 0x5696dc
      @@base0A = 0x88caf7
      @@base0B = 0x6cb5a1
      @@base0C = 0xb9c186
      @@base0D = 0xc2af7c
      @@base0E = 0xaf8bba
      @@base0F = 0x4669a1
      super
      @name = @@theme_name
    end
  end
end
