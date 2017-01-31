module Mrbmacs
  class SolarizedLightTheme
    attr_accessor :style_list, :foreground_color, :background_color, :font_color
    def initialize
      @foreground_color = Mrbmacs::COLOR_BASE00
      @background_color = Mrbmacs::COLOR_BASE3
      @font_color = {
        #                                italic, bold
        :color_foreground => [Mrbmacs::COLOR_BASE00, Mrbmacs::COLOR_BASE3, nil, nil],
        :color_builtin => [Mrbmacs::COLOR_GREEN, Mrbmacs::COLOR_BASE3, nil, nil],
        :color_comment => [Mrbmacs::COLOR_BASE1, Mrbmacs::COLOR_BASE3, true, nil],
        :color_constant => [Mrbmacs::COLOR_CYAN, Mrbmacs::COLOR_BASE3, nil, nil],
        :color_function_name => [Mrbmacs::COLOR_BLUE, Mrbmacs::COLOR_BASE3, nil, nil],
        :color_keyword => [Mrbmacs::COLOR_GREEN, Mrbmacs::COLOR_BASE3, nil, nil],
        :color_string => [Mrbmacs::COLOR_CYAN, Mrbmacs::COLOR_BASE3, nil, nil],
        :color_type => [Mrbmacs::COLOR_YELLOW, Mrbmacs::COLOR_BASE3, nil, nil],
        :color_variable_name => [Mrbmacs::COLOR_BLUE, Mrbmacs::COLOR_BASE3, nil, nil],
        :color_warning => [Mrbmacs::COLOR_RED, Mrbmacs::COLOR_BASE3, nil, true],
        :color_doc => [Mrbmacs::COLOR_BASE1, Mrbmacs::COLOR_BASE3, true, nil],
        :color_doc_string => [Mrbmacs::COLOR_BASE1, Mrbmacs::COLOR_BASE3, true, nil],
        :color_color_constant => [Mrbmacs::COLOR_GREEN, Mrbmacs::COLOR_BASE3, nil, nil],
        :color_comment_delimiter => [Mrbmacs::COLOR_BASE1, Mrbmacs::COLOR_BASE3, true, nil],
        :color_preprocessor => [Mrbmacs::COLOR_ORANGE, Mrbmacs::COLOR_BASE3, nil, nil],
        :color_negation_char => [Mrbmacs::COLOR_RED, Mrbmacs::COLOR_BASE3, nil, nil],
        :color_other_type => [Mrbmacs::COLOR_BLUE, Mrbmacs::COLOR_BASE3, true, nil],
        :color_regexp_grouping_construct => [Mrbmacs::COLOR_ORANGE, Mrbmacs::COLOR_BASE3, nil, nil],
        :color_special_keyword => [Mrbmacs::COLOR_RED, Mrbmacs::COLOR_BASE3, nil, nil],
        :color_exit => [Mrbmacs::COLOR_RED, Mrbmacs::COLOR_BASE3, nil, nil],
        :color_other_emphasized => [Mrbmacs::COLOR_VIOLET, Mrbmacs::COLOR_BASE3, true, true],
        :color_regexp_grouping_backslash => [Mrbmacs::COLOR_YELLOW, Mrbmacs::COLOR_BASE3, nil, nil],
        :color_brace_highlight => [@background_color, @foreground_color, nil, nil],
        :color_annotation => [Mrbmacs::COLOR_BASE03, Mrbmacs::COLOR_RED, true, nil],
      }
    end
  end
end

