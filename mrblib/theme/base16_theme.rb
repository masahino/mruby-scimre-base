module Mrbmacs
  # Base16Theme
  class Base16Theme < Theme
    @@base00 = 0x181818
    @@base01 = 0x282828
    @@base02 = 0x383838
    @@base03 = 0x585858
    @@base04 = 0xb8b8b8
    @@base05 = 0xd8d8d8
    @@base06 = 0xe8e8e8
    @@base07 = 0xf8f8f8
    @@base08 = 0x4246ab
    @@base09 = 0x5696dc
    @@base0A = 0x88caf7
    @@base0B = 0x6cb5a1
    @@base0C = 0xb9c186
    @@base0D = 0xc2af7c
    @@base0E = 0xaf8bba
    @@base0F = 0x4669a1

    def initialize
      if respond_to?(:set_pallete)
        set_pallete
      end
      @name = nil
      @foreground_color = @@base05
      @background_color = @@base00
      @font_color = {
        # [fore, back, italic_flag, bold_flag ]
        # basic colors
        color_foreground: [@@base05, @background_color, nil, nil],
        color_builtin: [@@base0E, @background_color, nil, nil],
        color_comment: [@@base03, @background_color, true, nil],
        color_constant: [@@base09, @background_color, nil, nil],
        color_function_name: [@@base0D, @background_color, nil, nil],
        color_keyword: [@@base0E, @background_color, nil, nil],
        color_string: [@@base0B, @background_color, nil, nil],
        color_type: [@@base0A, @background_color, nil, true],
        color_variable_name: [@@base08, @background_color, nil, nil],
        color_warning: [@@base08, @background_color, nil, true],
        color_regexp: [@@base0C, @background_color, nil, nil],
        color_preprocessor: [@@base0D, @background_color, nil, nil],
        # extra
        color_doc: [@@base0B, @background_color, true, nil],
        color_doc_string: [@@base0B, @background_color, true, nil],
        color_color_constant: [@@base09, @background_color, nil, nil],
        color_comment_delimiter: [@@base03, @background_color, true, nil],
        color_negation_char: [@@base0B, @background_color, nil, nil],
        color_other_type: [@@base05, @background_color, true, nil],
        color_regexp_grouping_construct: [@@base0E, @background_color, nil, nil],
        color_special_keyword: [@@base0E, @background_color, nil, nil],
        color_exit: [@@base0E, @background_color, nil, nil],
        color_other_emphasized: [@@base05, @background_color, true, true],
        color_regexp_grouping_backslash: [@@base05, @background_color, nil, nil],
        # additional
        color_brace_highlight: [@background_color, @foreground_color, nil, nil],
        color_annotation: [@@base05, @@base08, true, nil],
        color_annotation_info: [@@base06, @@base03, true, nil],
        color_annotation_warn: [@@base06, @@base0F, true, nil],
        color_annotation_error: [@@base06, @@base08, true, nil],
        color_linenumber: [@@base04, @@base01, nil, nil],
        color_caret_line: [@foreground_color, @@base01, nil, nil],
        color_indent_guide: [@@base03, @background_color, nil, nil]
      }
    end
  end
end
