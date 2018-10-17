module Mrbmacs
  COLOR_BASE03 = 0
  COLOR_BASE02 = 0
  COLOR_BASE01 = 0
  COLOR_BASE00 = 0
  COLOR_BASE0  = 0
  COLOR_BASE1  = 0
  COLOR_BASE2  = 0
  COLOR_BASE3  = 0
  COLOR_YELLOW = 0
  COLOR_ORANGE = 0
  COLOR_RED    = 0
  COLOR_MAGENTA = 0
  COLOR_VIOLET = 0
  COLOR_BLUE   = 0
  COLOR_CYAN   = 0
  COLOR_GREEN  = 0
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

