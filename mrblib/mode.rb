module Mrbmacs
  $mode_list = {
	# ruby-mode
    ".rb" => "ruby",
    ".c" => "cpp",
    ".h" => "cpp",
    ".cpp" => "cpp",
    ".cxx" => "cpp",
    ".md" => "markdown",
    ".txt" => "fundamental",
    ".html" => "hypertext",
    ".htm" => "hypertext",
    ".sh" => "bash",
    "" => "fundamental",
  }
    
  class Mode
    def name
      @name
    end
    
    def self.get_mode_by_suffix(suffix)
      if $mode_list.has_key?(suffix)
        $mode_list[suffix]
      else
        "fundamental"
      end
    end

    def self.set_mode_by_filename(filename)
      cur_mode = get_mode_by_suffix(File.extname(filename))
      mode = Mrbmacs.const_get(cur_mode.capitalize+"Mode").new
      return mode
    end
      
    def initialize
      @name = "default"
      @keyword_list = ""
      @style = []
      @indent = 2
    end

    def set_style(view_win, theme)
      for i in 0..@style.length-1
        color = theme.font_color[@style[i]]
        if color[0] # foreground
          view_win.sci_style_set_fore(i, color[0])
        end
        if color[1] # background
          view_win.sci_style_set_back(i, color[1])
        end
        if color[2] # italic
          view_win.sci_style_set_italic(i, color[2])
        end
        if color[3] # bold
          view_win.sci_style_set_bold(i, color[3])
        end
      end

#     # bracelight
#      view_win.sci_style_set_fore(34, theme.background_color)
#      view_win.sci_style_set_back(34, theme.foreground_color)

      view_win.sci_set_keywords(0, @keyword_list)
      view_win.sci_set_property("fold", "1")
      view_win.sci_set_tab_width(@indent)
      view_win.sci_set_use_tabs(false)
      view_win.sci_set_tab_indents(true)
      view_win.sci_set_back_space_un_indents(true)
      view_win.sci_set_indent(@indent)
      view_win.sci_set_wrap_mode(Scintilla::SC_WRAP_CHAR)
    end

    def config
    end
    
    def get_indent_level(view_win)
      0
    end

    def syntax_check(view_win)
      []
    end

    def get_completion_list(view_win)
      [0, []]
    end
  end

  class FundamentalMode < Mode
    def initialize
      super.initialize
      @name = "fundamental"
    end
  end
end
