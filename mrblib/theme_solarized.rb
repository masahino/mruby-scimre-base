module Mrbmacs
  class SolarizedDarkTheme
    attr_accessor :style_list, :foreground_color, :background_color, :font_color
    def initialize
      @foreground_color = Mrbmacs::COLOR_BASE0
      @background_color = Mrbmacs::COLOR_BASE03
      @font_color = {
        #                                italic, bold
        :color_foreground => [Mrbmacs::COLOR_BASE0, nil, nil],
        :color_builtin => [Mrbmacs::COLOR_GREEN, nil, nil],
        :color_comment => [Mrbmacs::COLOR_BASE01, true, nil],
        :color_constant => [Mrbmacs::COLOR_CYAN, nil, nil],
        :color_function_name => [Mrbmacs::COLOR_BLUE, nil, nil],
        :color_keyword => [Mrbmacs::COLOR_GREEN, nil, nil],
        :color_string => [Mrbmacs::COLOR_CYAN, nil, nil],
        :color_type => [Mrbmacs::COLOR_YELLOW, nil, nil],
        :color_variable_name => [Mrbmacs::COLOR_BLUE, nil, nil],
        :color_warning => [Mrbmacs::COLOR_RED, nil, true],
        :color_doc => [Mrbmacs::COLOR_BASE01, true, nil],
        :color_doc_string => [Mrbmacs::COLOR_BASE01, true, nil],
        :color_color_constant => [Mrbmacs::COLOR_GREEN, nil, nil],
        :color_comment_delimiter => [Mrbmacs::COLOR_BASE01, true, nil],
        :color_preprocessor => [Mrbmacs::COLOR_ORANGE, nil, nil],
        :color_negation_char => [Mrbmacs::COLOR_RED, nil, nil],
        :color_other_type => [Mrbmacs::COLOR_BLUE, true, nil],
        :color_regexp_grouping_construct => [Mrbmacs::COLOR_ORANGE, nil, nil],
        :color_special_keyword => [Mrbmacs::COLOR_RED, nil, nil],
        :color_exit => [Mrbmacs::COLOR_RED, nil, nil],
        :color_other_emphasized => [Mrbmacs::COLOR_VIOLET, true, true],
        :color_regexp_grouping_backslash => [Mrbmacs::COLOR_YELLOW, nil, nil],
      }
    end
  end
end

