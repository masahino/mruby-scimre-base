module Mrbmacs
  class SolarizedTheme < Theme
    @@base03 = 0x362b00
    @@base02 = 0x423607
    @@base01 = 0x756e58
    @@base00 = 0x969583
    @@base0  = 0x969483
    @@base1  = 0xa1a193
    @@base2  = 0xd5e8ee
    @@base3  = 0xe3f6fd
    @@yellow = 0x0089b5
    @@orange = 0x164bcb
    @@red    = 0x2f32dc
    @@magenta = 0x8236d3
    @@violet = 0xc4716c
    @@blue   = 0xd28b26
    @@cyan   = 0x98a12a
    @@green  = 0x009985

    def initialize
      set_pallete if respond_to?(:set_pallete)
      super
      @name = nil
    end
  end
end
