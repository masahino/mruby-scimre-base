module Mrbmacs
  class SolarizedLightTheme < SolarizedTheme
    @@theme_name = "solarized-light"
    def initialize
      super
      @name = @@theme_name
      @foreground_color = @@base00
      @background_color = @@base3
      @font_color = {
        #                                italic, bold
        :color_foreground => [@@base00, @@base3, nil, nil],
        :color_builtin => [@@green, @@base3, nil, nil],
        :color_comment => [@@base1, @@base3, true, nil],
        :color_constant => [@@cyan, @@base3, nil, nil],
        :color_function_name => [@@blue, @@base3, nil, nil],
        :color_keyword => [@@green, @@base3, nil, nil],
        :color_string => [@@cyan, @@base3, nil, nil],
        :color_type => [@@yellow, @@base3, nil, nil],
        :color_variable_name => [@@blue, @@base3, nil, nil],
        :color_warning => [@@red, @@base3, nil, true],
        :color_doc => [@@base1, @@base3, true, nil],
        :color_doc_string => [@@base1, @@base3, true, nil],
        :color_color_constant => [@@green, @@base3, nil, nil],
        :color_comment_delimiter => [@@base1, @@base3, true, nil],
        :color_preprocessor => [@@orange, @@base3, nil, nil],
        :color_negation_char => [@@red, @@base3, nil, nil],
        :color_other_type => [@@blue, @@base3, true, nil],
        :color_regexp_grouping_construct => [@@orange, @@base3, nil, nil],
        :color_special_keyword => [@@red, @@base3, nil, nil],
        :color_exit => [@@red, @@base3, nil, nil],
        :color_other_emphasized => [@@violet, @@base3, true, true],
        :color_regexp_grouping_backslash => [@@yellow, @@base3, nil, nil],
        #
        :color_brace_highlight => [@background_color, @foreground_color, nil, nil],
        :color_annotation => [@@base03, @@red, true, nil],
        :color_linenumber => [@@base00, @@base2, nil, nil],
        :color_caret_line => [@foreground_color, @@base2, nil, nil],
      }
    end
  end
end

