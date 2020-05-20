module Mrbmacs
  class Base16Theme < Theme
    @@base00 = 0x181818
    @@base01 = 0x282828
    @@base02 = 0x383838
    @@base03 = 0x585858
    @@base04 = 0xb8b8b8
    @@base05 = 0xd8d8d8
    @@base06 = 0xe8e8e8
    @@base07 = 0xf8f8f8
    @@base08 = 0xab4642
    @@base09 = 0xdc9656
    @@base0A = 0xf7ca88
    @@base0B = 0xa1b56c
    @@base0C = 0x86c1b9
    @@base0D = 0x7cafc2
    @@base0E = 0xba8baf
    @@base0F = 0xa16946
    def initialize
      if respond_to?(:set_pallete)
        set_pallete
      end
      @name = nil
      @foreground_color = @@base05
      @background_color = @@base00
      @font_color = {
        # [fore, back, italic_flag, bold_flag ]
        :color_foreground => [@@base05, @background_color, nil, nil],
        :color_builtin => [@@base0D, @background_color, nil, nil],
        :color_comment => [@@base03, @background_color, true, nil],
        :color_constant => [@@base09, @background_color, nil, nil],
        :color_function_name => [@@base0D, @background_color, nil, nil],
        :color_keyword => [@@base0E, @background_color, nil, true],
        :color_string => [@@base0B, @background_color, nil, nil],
        :color_type => [@@base0A, @background_color, nil, true],
        :color_type => [@@base0A, @background_color, nil, true],
        :color_variable_name => [@@base08, @background_color, nil, nil],
        :color_warning => [@@base08, @background_color, nil, true],
        :color_doc => [@@base01, @background_color, true, nil],
        :color_doc_string => [@@base04, @background_color, true, nil],
        :color_color_constant => [@@base09, @background_color, nil, nil],
        :color_comment_delimiter => [@@base03, @background_color, true, nil],
        :color_preprocessor => [@@base0D, @background_color, nil, nil],
        :color_negation_char => [@@base0B, @background_color, nil, nil],
        :color_other_type => [@@base05, @background_color, true, nil],
        :color_regexp_grouping_construct => [@@base0E, @background_color, nil, nil],
        :color_special_keyword => [@@base0E, @@base0E, nil, nil],
        :color_exit => [@@base0E, @@base05, nil, nil],
        :color_other_emphasized => [@@base05, @background_color, true, true],
        :color_regexp_grouping_backslash => [@@base05, @background_color, nil, nil],
        #
        :color_brace_highlight => [@background_color, @foreground_color, nil, nil],
        :color_annotation => [@@base03, @@base08, true, nil],
        :color_linenumber => [@@base04, @@base01, nil, nil],
      }
    end
  end
end

