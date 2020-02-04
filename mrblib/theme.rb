module Mrbmacs
  class Application
    def select_theme(theme_name = nil)
      $stderr.puts "select theme"
      if theme_name == nil
        theme_name = @frame.echo_gets("theme:",) do |input_text|
          comp_list = []
          @themes.each do |name, klass|
            if name.start_with?(input_text)
              comp_list.push name
            end
          end
          if $DEBUG
            $stderr.puts comp_list
          end
          [comp_list.join(" "), input_text.length]
        end
      end
      $stderr.puts theme_name
      if theme_name != nil
        @theme = @themes[theme_name].new
        if @theme.respond_to?(:set_pallete)
          @theme.set_pallete
        end
        set_default_style()
        @current_buffer.mode.set_style(@frame.view_win, @theme)
      end
    end
  end

  class Theme
    attr_accessor :style_list, :foreground_color, :background_color, :font_color, :name
    def initialize
      @name = "default"
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
        # 
        :color_brace_highlight => [@background_color, @foreground_color, nil, nil],
        :color_annotation => [@background_color, @foreground_color, true, nil],
        :color_linenumber => [@foreground_color, @background_color, nil, nil],
      }
    end

    def self.create_theme_list
      list = Hash.new
      ObjectSpace.each_object(Class) do |klass|
        if klass < self
          list[klass.new.name] = klass
        end
      end
      list
    end
  end
end

