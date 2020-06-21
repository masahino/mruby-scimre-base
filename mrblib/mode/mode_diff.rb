module Mrbmacs
  class DiffMode < Mode
    include Scintilla
    def initialize
      super
      @name = "diff"
      @lexer = "diff"
      @keyword_list = ""
      @style = [
        :color_foreground, #define SCE_DIFF_DEFAULT 0
        :color_comment, #define SCE_DIFF_COMMENT 1
        :color_foreground, #define SCE_DIFF_COMMAND 2
        :color_foreground, #define SCE_DIFF_HEADER 3
        :color_builtin, #define SCE_DIFF_POSITION 4
        :color_variable_name, #define SCE_DIFF_DELETED 5
        :color_string, #define SCE_DIFF_ADDED 6
        :color_keyword, #define SCE_DIFF_CHANGED 7
        :color_string, #define SCE_DIFF_PATCH_ADD 8
        :color_variable_name, #define SCE_DIFF_PATCH_DELETE 9
        :color_variable_name, #define SCE_DIFF_REMOVED_PATCH_ADD 10
        :color_variable_name, #define SCE_DIFF_REMOVED_PATCH_DELETE 11
        ]
    end

    def set_style(view_win, theme)
      super
      view_win.sci_set_property("fold.compact", "1")
    end

  end
end
