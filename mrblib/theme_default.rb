module Mrbmacs
  class Theme
    attr_accessor :style_list, :foreground_color, :background_color, :font_color
    def initialize
      @foregronud_color = 0xffffff
      @background_color = 0
      @style_list = {}
      @font_color = {
        # [fore, back, italic_flag, bold_flag ]
        :color_foreground => [@foreground_color, @background_color, nil, nil],
        :color_builtin => [@foreground_color, @background_color, nil, nil],
        :color_comment => [@foreground_color, @background_color, nil, nil],
        :color_constant => [@foreground_color, @background_color, nil, nil],
        :color_function_name => [@foreground_color, @background_color, nil, nil],
        :color_keyword => [@foreground_color, @background_color, nil, nil],
        :color_string => [@foreground_color, @background_color, nil, nil],
        :color_type => [@foreground_color, @background_color, nil, nil],
        :color_variable_name => [@foreground_color, @background_color, nil, nil],
        :color_warning => [@foreground_color, @background_color, nil, nil],
        :color_doc => [@foreground_color, @background_color, nil, nil],
        :color_doc_string => [@foreground_color, @background_color, nil, nil],
        :color_color_constant => [@foreground_color, @background_color, nil, nil],
        :color_comment_delimiter => [@foreground_color, @background_color, nil, nil],
        :color_preprocessor => [@foreground_color, @background_color, nil, nil],
        :color_negation_char => [@foreground_color, @background_color, nil, nil],
        :color_other_type => [@foreground_color, @background_color, nil, nil],
        :color_regexp_grouping_construct => [@foreground_color, @background_color, nil, nil],
        :color_special_keyword => [@foreground_color, @background_color, nil, nil],
        :color_exit => [@foreground_color, @background_color, nil, nil],
        :color_other_emphasized => [@foreground_color, @background_color, nil, nil],
        :color_regexp_grouping_backslash => [@foreground_color, @background_color, nil, nil],
        :color_brace_highlight => [@background_color, @foreground_color, nil, nil],
        :color_annotation => [@background_color, @foreground_color, true, nil],
      }
    end
  end
end

