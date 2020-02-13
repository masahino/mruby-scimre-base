module Mrbmacs
  class Application
    def select_theme(theme_name = nil)
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
      @foreground_color = 0xffffff
      @background_color = 0
      @style_list = {}
      @font_color = {
        # [fore, back, italic_flag, bold_flag ]
        :color_foreground => [@foreground_color, @background_color, nil, nil],
        :color_builtin => [0x00ff00, @background_color, nil, nil],
        :color_comment => [0xc0c0c0, @background_color, nil, nil],
        :color_constant => [0x00ffff, @background_color, nil, nil],
        :color_function_name => [0x0000ff, @background_color, nil, nil],
        :color_keyword => [0x00ff00, @background_color, nil, nil],
        :color_string => [0x00ffff, @background_color, nil, nil],
        :color_type => [0xffff00, @background_color, nil, nil],
        :color_variable_name => [0x0000ff, @background_color, nil, nil],
        :color_warning => [0xff0000, @background_color, nil, nil],
        :color_doc => [0xc0c0c0, @background_color, nil, nil],
        :color_doc_string => [0xc0c0c0, @background_color, nil, nil],
        :color_color_constant => [0x00ff00, @background_color, nil, nil],
        :color_comment_delimiter => [0xc0c0c0, @background_color, nil, nil],
        :color_preprocessor => [0x800000, @background_color, nil, nil],
        :color_negation_char => [0xff0000, @background_color, nil, nil],
        :color_other_type => [0x0000ff, @background_color, nil, nil],
        :color_regexp_grouping_construct => [0x800000, @background_color, nil, nil],
        :color_special_keyword => [0xff0000, @background_color, nil, nil],
        :color_exit => [0xff0000, @background_color, nil, nil],
        :color_other_emphasized => [0xff00ff, @background_color, nil, nil],
        :color_regexp_grouping_backslash => [0xffff00, @background_color, nil, nil],
        # 
        :color_brace_highlight => [@background_color, @foreground_color, nil, nil],
        :color_annotation => [@background_color, 0xff0000, true, nil],
        :color_linenumber => [@foreground_color, 0x404040, nil, nil],
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

