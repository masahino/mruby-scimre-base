module Mrbmacs
  class Theme
    attr_accessor :style_list, :foreground_color, :background_color, :font_color
    def initialize
      @foregronud_color = 0xffffff
      @background_color = 0
      @style_list = {}
      @font_color = {
        #                                italic
        :color_foreground => [@foreground_color, nil, nil],
        :color_builtin => [@foreground_color, nil, nil],
        :color_comment => [@foreground_color, nil, nil],
        :color_constant => [@foreground_color, nil, nil],
        :color_function_name => [@foreground_color, nil, nil],
        :color_keyword => [@foreground_color, nil, nil],
        :color_string => [@foreground_color, nil, nil],
        :color_type => [@foreground_color, nil, nil],
        :color_variable_name => [@foreground_color, nil, nil],
        :color_warning => [@foreground_color, nil, nil],
        :color_doc => [@foreground_color, nil, nil],
        :color_doc_string => [@foreground_color, nil, nil],
        :color_color_constant => [@foreground_color, nil, nil],
        :color_comment_delimiter => [@foreground_color, nil, nil],
        :color_preprocessor => [@foreground_color, nil, nil],
        :color_negation_char => [@foreground_color, nil, nil],
        :color_other_type => [@foreground_color, nil, nil],
        :color_regexp_grouping_construct => [@foreground_color, nil, nil],
        :color_special_keyword => [@foreground_color, nil, nil],
        :color_exit => [@foreground_color, nil, nil],
        :color_other_emphasized => [@foreground_color, nil, nil],
        :color_regexp_grouping_backslash => [@foreground_color, nil, nil],
      }
    end
  end
end

