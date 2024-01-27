module Mrbmacs
  # base
  class FrameBase
    def echo_set_prompt(prompt)
      raise NotImplementedError
    end

    def read_buffername(prompt)
      echo_gets(prompt)
    end

    def echo_gets(prompt, text = '', &block)
      raise NotImplementedError
    end

    def echo_style_base(echo_win)
      echo_win.sci_style_clear_all
      echo_win.sci_set_focus(false)
      echo_win.sci_autoc_set_choose_single(1)
      echo_win.sci_autoc_set_auto_hide(false)
      echo_win.sci_set_margin_typen(3, 4)
      # echo_win.sci_set_caretstyle Scintilla::CARETSTYLE_BLOCK_AFTER |
      # Scintilla::CARETSTYLE_OVERSTRIKE_BLOCK | Scintilla::CARETSTYLE_BLOCK
      echo_win.sci_set_wrap_mode(Scintilla::SC_WRAP_CHAR)
      echo_win.sci_autoc_set_max_height(16) if Scintilla::PLATFORM != :CURSES_WIN32
    end

    def echo_puts(text)
      raise NotImplementedError
    end
  end
end
