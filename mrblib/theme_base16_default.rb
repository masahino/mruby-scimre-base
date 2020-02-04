module Mrbmacs
  class Base16Theme < Theme
    def initialize
      @name = "base16"
      @foreground_color = Mrbmacs::BASE16_BASE05
      @background_color = Mrbmacs::BASE16_BASE00
      @font_color = {
        # [fore, back, italic_flag, bold_flag ]
        :color_foreground => [Mrbmacs::BASE16_BASE05, @background_color, nil, nil],
        :color_builtin => [Mrbmacs::BASE16_BASE0D, @background_color, nil, nil],
        :color_comment => [Mrbmacs::BASE16_BASE03, @background_color, true, nil],
        :color_constant => [Mrbmacs::BASE16_BASE09, @background_color, nil, nil],
        :color_function_name => [Mrbmacs::BASE16_BASE0D, @background_color, nil, nil],
        :color_keyword => [Mrbmacs::BASE16_BASE0E, @background_color, nil, true],
        :color_string => [Mrbmacs::BASE16_BASE0B, @background_color, nil, nil],
        :color_type => [Mrbmacs::BASE16_BASE0A, @background_color, nil, true],
        :color_type => [Mrbmacs::BASE16_BASE0A, @background_color, nil, true],
        :color_variable_name => [Mrbmacs::BASE16_BASE08, @background_color, nil, nil],
        :color_warning => [Mrbmacs::BASE16_BASE08, @background_color, nil, true],
        :color_doc => [Mrbmacs::BASE16_BASE01, @background_color, true, nil],
        :color_doc_string => [Mrbmacs::BASE16_BASE04, @background_color, true, nil],
        :color_color_constant => [Mrbmacs::BASE16_BASE09, @background_color, nil, nil],
        :color_comment_delimiter => [Mrbmacs::BASE16_BASE03, @background_color, true, nil],
        :color_preprocessor => [Mrbmacs::BASE16_BASE0D, @background_color, nil, nil],
        :color_negation_char => [Mrbmacs::BASE16_BASE0B, @background_color, nil, nil],
        :color_other_type => [Mrbmacs::BASE16_BASE05, @background_color, true, nil],
        :color_regexp_grouping_construct => [Mrbmacs::BASE16_BASE0E, @background_color, nil, nil],
        :color_special_keyword => [Mrbmacs::BASE16_BASE0E, Mrbmacs::BASE16_BASE0E, nil, nil],
        :color_exit => [Mrbmacs::BASE16_BASE0E, Mrbmacs::BASE16_BASE05, nil, nil],
        :color_other_emphasized => [Mrbmacs::BASE16_BASE05, @background_color, true, true],
        :color_regexp_grouping_backslash => [Mrbmacs::BASE16_BASE05, @background_color, nil, nil],
        #
        :color_brace_highlight => [@background_color, @foreground_color, nil, nil],
        :color_annotation => [Mrbmacs::BASE16_BASE03, Mrbmacs::BASE16_BASE08, true, nil],
        :color_linenumber => [Mrbmacs::BASE16_BASE04, Mrbmacs::BASE16_BASE01, nil, nil],
      }
    end
  end
end

