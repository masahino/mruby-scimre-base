module Mrbmacs
  class HtmlMode < Mode
    include Scintilla
    def initialize
      super.initialize
      @name = "html"
      @lexer = "hypertext"
      @keyword_list = ""
      @style = [
        :color_foreground, #define SCE_H_DEFAULT 0
        :color_keyword,  #define SCE_H_TAG 1
        :color_warning, #define SCE_H_TAGUNKNOWN 2
        :color_variable_name, #define SCE_H_ATTRIBUTE 3
        :color_warning, #define SCE_H_ATTRIBUTEUNKNOWN 4
        :color_foreground, #define SCE_H_NUMBER 5
        :color_string, #define SCE_H_DOUBLESTRING 6
        :color_string, #define SCE_H_SINGLESTRING 7
        :color_foreground, #define SCE_H_OTHER 8
        :color_comment, #define SCE_H_COMMENT 9
        :color_foreground, #define SCE_H_ENTITY 10
        :color_foreground, #define SCE_H_TAGEND 11
        ]
    end

    def set_style(view_win, theme)
      super
      view_win.sci_set_property("fold.html", "1")
    end

    def get_indent_level(view_win)
      line = view_win.sci_line_from_position(view_win.sci_get_current_pos())
      level = view_win.sci_get_fold_level(line) & Scintilla::SC_FOLDLEVELNUMBERMASK - Scintilla::SC_FOLDLEVELBASE
      cur_line = view_win.sci_get_curline()[0]
      if $DEBUG
        $stderr.puts "level = #{level}"
      end
      if level > 0 and cur_line =~/^\s*<\/.*>\s*$/
        level -= 1
      end
      return level
    end
  end
end
