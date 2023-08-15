module Mrbmacs
  # mode for preview-theme
  class PreviewthemeMode < Mode
    attr_reader :style

    def initialize
      super.initialize
      @name = 'previewtheme'
      @lexer = nil
      @keyword_list = ''
      @style = [
        :color_foreground,
        :color_builtin,
        :color_comment,
        :color_constant,
        :color_function_name,
        :color_keyword,
        :color_string,
        :color_type,
        :color_variable_name,
        :color_warning,
        :color_preprocessor,
        :color_regexp,
        :color_doc,
        :color_doc_string,
        :color_color_constant,
        :color_comment_delimiter,
        :color_negation_char,
        :color_other_type,
        :color_regexp_grouping_construct,
        :color_special_keyword,
        :color_exit,
        :color_other_emphasized,
        :color_regexp_grouping_backslash,
        :color_brace_highlight,
        :color_annotation,
        :color_annotation_info,
        :color_annotation_warn,
        :color_annotation_error,
        :color_linenumber,
        :color_caret_line,
        :color_indent_guide
      ]
      #      @keymap['Enter'] = 'compilation_open_file'
    end

    def set_style(view_win, theme)
      super
      view_win.sci_set_property('fold.compact', '1')
    end

    def is_end_of_block(line)
      if line =~ /^\s*(end|else|fi|done|}).*$/
        true
      else
        false
      end
    end

    def set_lexer(view_win)
      #      view_win.sci_set_lexer(Scintilla::SCLEX_CONTAINER)
    end
  end
end
