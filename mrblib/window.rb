# coding: utf-8
module Mrbmacs
  class EditWindow
    attr_accessor :sci, :modeline, :frame
    attr_accessor :command_list
    attr_accessor :buffer
    attr_accessor :x1, :y1, :x2, :y2, :width, :height
    def initialize(frame, buffer, x1, y1, width, height)
      $stderr.puts "not yet implemented"
    end

    def set_buffer(buffer)
      @sci.sci_set_docpointer(buffer.docpointer)
      @sci.sci_set_lexer_language(buffer.mode.name)
#      buffer.mode.set_style(view_win, @theme)
    end

    def compute_area
    end

    def refresh
    end

    def delete
    end

    def focus_in()
      @sci.sci_set_focus(true)
      @sci.refresh
    end

    def focus_out()
      @sci.sci_set_focus(false)
      @sci.refresh
    end

    def set_margin()
      @sci.sci_set_margin_widthn(0, @sci.sci_text_width(Scintilla::STYLE_LINENUMBER, "_99999"))
#      @sci.sci_set_margin_widthn(1, 1)
#      @sci.sci_set_margin_typen(1, 0)
      @sci.sci_set_margin_maskn(1, Scintilla::SC_MASK_FOLDERS)
      @sci.sci_set_marginsensitiven(1, 1)
      @sci.sci_set_automatic_fold(Scintilla::SC_AUTOMATICFOLD_CLICK)
    end

    def set_sci_default()
      @sci.sci_set_codepage(Scintilla::SC_CP_UTF8)
      @sci.sci_set_viewws(3)
      @sci.sci_auto_cset_choose_single(1)
      @sci.sci_auto_cset_auto_hide(false)
      @sci.sci_set_property("fold", "1")
      @sci.sci_set_wrap_mode(Scintilla::SC_WRAP_CHAR)
    end

    def set_theme_base(theme)
      @sci.sci_style_clear_all
      @sci.sci_style_set_fore(Scintilla::STYLE_DEFAULT, theme.foreground_color)
      @sci.sci_style_set_back(Scintilla::STYLE_DEFAULT, theme.background_color)
      if theme.font_color[:color_brace_highlight]
        @sci.sci_style_set_fore(Scintilla::STYLE_BRACELIGHT,
          theme.font_color[:color_brace_highlight][0])
        @sci.sci_style_set_back(Scintilla::STYLE_BRACELIGHT,
          theme.font_color[:color_brace_highlight][1])
      end
      if theme.font_color[:color_annotation]
        @sci.sci_style_set_fore(254, theme.font_color[:color_annotation][0])
        @sci.sci_style_set_back(254, theme.font_color[:color_annotation][1])
        @sci.sci_annotation_set_visible(Scintilla::ANNOTATION_BOXED)
      end
      if theme.font_color[:color_linenumber]
        @sci.sci_style_set_fore(Scintilla::STYLE_LINENUMBER,
          theme.font_color[:color_linenumber][0])
        sci.sci_style_set_back(Scintilla::STYLE_LINENUMBER,
          theme.font_color[:color_linenumber][1])
      end
      @sci.sci_set_sel_fore(true, theme.background_color)
      @sci.sci_set_sel_back(true, theme.foreground_color)
    end

    def set_theme(theme)
      set_theme_base(theme)
    end

  end
end
