module Mrbmacs
  #  COLOR_BASE03
  #  COLOR_BASE02
  #  COLOR_BASE01
  #  COLOR_BASE00
  #  COLOR_BASE0
  #  COLOR_BASE1
  #  COLOR_BASE2
  #  COLOR_BASE3
  #  COLOR_YELLOW
  #  COLOR_ORANGE
  #  COLOR_RED
  #  COLOR_MAGENTA
  #  COLOR_VIOLET
  #  COLOR_BLUE
  #  COLOR_CYAN
  #  COLOR_GREEN

  class SolarizedDarkTheme < SolarizedTheme
    @@theme_name = 'solarized-dark'
    def initialize
      super
      @name = @@theme_name
      @foreground_color = @@base0
      @background_color = @@base03
      @font_color = {
        # [fore, back, italic_flag, bold_flag ]
        # basic colors
        color_foreground: [@@base0, @@base03, nil, nil],
        color_builtin: [@@green, @@base03, nil, nil],
        color_comment: [@@base01, @@base03, true, nil],
        color_constant: [@@cyan, @@base03, nil, nil],
        color_function_name: [@@blue, @@base03, nil, nil],
        color_keyword: [@@green, @@base03, nil, true],
        color_string: [@@cyan, @@base03, nil, nil],
        color_type: [@@yellow, @@base03, nil, true],
        color_variable_name: [@@blue, @@base03, nil, nil],
        color_warning: [@@red, @@base03, nil, true],
        color_preprocessor: [@@orange, @@base03, nil, nil],
        color_regexp: [@@orange, @@base03, nil, nil],
        # extra
        color_doc: [@@base01, @@base03, true, nil],
        color_doc_string: [@@base01, @@base03, true, nil],
        color_color_constant: [@@green, @@base03, nil, nil],
        color_comment_delimiter: [@@base01, @@base03, true, nil],
        color_negation_char: [@@red, @@base03, nil, nil],
        color_other_type: [@@blue, @@base03, true, nil],
        color_regexp_grouping_construct: [@@orange, @@base03, nil, nil],
        color_special_keyword: [@@red, @@base03, nil, nil],
        color_exit: [@@red, @@base03, nil, nil],
        color_other_emphasized: [@@violet, @@base03, true, true],
        color_regexp_grouping_backslash: [@@yellow, @@base03, nil, nil],
        # additional
        color_brace_highlight: [@background_color, @foreground_color, nil, nil],
        color_annotation: [@@base3, @@red, true, nil],
        color_annotation_info: [@@base3, @@base01, true, nil],
        color_annotation_warn: [@@base3, @@yellow, true, nil],
        color_annotation_error: [@@base3, @@red, true, nil],
        color_linenumber: [@@base0, @@base02, nil, nil],
        color_caret_line: [@foreground_color, @@base02, nil, nil],
        color_indent_guide: [@@base01, @background_color, nil, nil]
      }
    end
  end
end
