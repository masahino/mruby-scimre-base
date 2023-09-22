module Mrbmacs
  # Command
  module Command
    def select_theme(theme_name = nil)
      themes = Theme.create_theme_list
      if theme_name.nil?
        theme_name = @frame.echo_gets('theme:') do |input_text|
          comp_list = []
          themes.each do |name|
            comp_list.push name if name.start_with?(input_text)
          end
          [comp_list.sort.join(@frame.echo_win.sci_autoc_get_separator.chr), input_text.length]
        end
      end
      unless theme_name.nil?
        if themes.include?(theme_name)
          @theme = Theme.find_by_name(theme_name).new
          @frame.apply_theme(@theme)
          apply_theme_to_mode(@current_buffer.mode, @frame.edit_win, @theme)
        else
          @frame.echo_puts "#{theme_name} not found"
        end
      end
    end
  end

  # Theme
  class Theme
    attr_accessor :foreground_color, :background_color, :font_color, :name

    def initialize
      @name = 'default'
      @foreground_color = 0xffffff
      @background_color = 0
      @font_color = {
        # [fore, back, italic_flag, bold_flag ]
        # basic color
        color_foreground: [@foreground_color, @background_color, nil, nil],
        color_builtin: [0x00ff00, @background_color, nil, nil],
        color_comment: [0xc0c0c0, @background_color, nil, nil],
        color_constant: [0x00ffff, @background_color, nil, nil],
        color_function_name: [0x0000ff, @background_color, nil, nil],
        color_keyword: [0x00ff00, @background_color, nil, nil],
        color_string: [0x00ffff, @background_color, nil, nil],
        color_type: [0xffff00, @background_color, nil, nil],
        color_variable_name: [0x0000ff, @background_color, nil, nil],
        color_warning: [0xff0000, @background_color, nil, nil],
        color_preprocessor: [0x800000, @background_color, nil, nil],
        color_regexp: [0x800000, @background_color, nil, nil],
        # extra
        color_doc: [0xc0c0c0, @background_color, nil, nil],
        color_doc_string: [0xc0c0c0, @background_color, nil, nil],
        color_color_constant: [0x00ff00, @background_color, nil, nil],
        color_comment_delimiter: [0xc0c0c0, @background_color, nil, nil],
        color_negation_char: [0xff0000, @background_color, nil, nil],
        color_other_type: [0x0000ff, @background_color, nil, nil],
        color_regexp_grouping_construct: [0x800000, @background_color, nil, nil],
        color_special_keyword: [0xff0000, @background_color, nil, nil],
        color_exit: [0xff0000, @background_color, nil, nil],
        color_other_emphasized: [0xff00ff, @background_color, nil, nil],
        color_regexp_grouping_backslash: [0xffff00, @background_color, nil, nil],
        # additonal
        color_brace_highlight: [@background_color, @foreground_color, nil, nil],
        color_annotation: [@background_color, 0xff0000, true, nil],
        color_annotation_info: [@background_color, 0x808080, true, nil],
        color_annotation_warn: [@background_color, 0xffff00, true, nil],
        color_annotation_error: [@background_color, 0xff0000, true, nil],
        color_linenumber: [@foreground_color, 0x404040, nil, nil],
        color_caret_line: [@foreground_color, 0x404040, nil, nil],
        color_indent_guide: [0xc0c0c0, @background_color, nil, nil],
        color_marker_breakpoint: [0xff0000, 0x404040, nil, nil],
        color_marker_current: [0x0000ff, 0x404040, nil, nil],
        # frame
        color_mode_line: [@background_color, 0xc0c0c0, nil, nil],
        color_mode_line_inactive: [0xc0c0c0, @background_color, nil, nil]
      }
    end

    def annotation_style(severity)
      case severity
      when :info
        251
      when :warn
        252
      when :error
        253
      else
        254
      end
    end

    def self.find_by_name(name)
      theme = Theme
      ObjectSpace.each_object(Class) do |klass|
        next unless klass < self

        if klass.class_variable_defined?(:@@theme_name) && (klass.class_variable_get(:@@theme_name) == name)
          theme = klass
          break
        end
      end
      theme
    end

    def self.create_theme_list
      list = []
      ObjectSpace.each_object(Class) do |klass|
        next unless klass < self

        list.push(klass.class_variable_get(:@@theme_name)) if klass.class_variable_defined? :@@theme_name
      end
      list
    end
  end
end
