# test module for mruby-mrbmacs-base
$test_echo_gets = {
  :call_block => false,
  :input_text => "test",
  :output_text => "test"
}
module Mrbmacs
  # solarized theme
  COLOR_BASE03 = 0x002b36
  COLOR_BASE02 = 0x073642
  COLOR_BASE01 = 0x586e75
  COLOR_BASE00 = 0x657b83
  COLOR_BASE0  = 0x839496
  COLOR_BASE1  = 0x93a1a1
  COLOR_BASE2  = 0xeee8d5
  COLOR_BASE3  = 0xfdf6e3
  COLOR_YELLOW = 0xb58900
  COLOR_ORANGE = 0xcb4b16
  COLOR_RED    = 0xdc322f
  COLOR_MAGENTA = 0xd33682
  COLOR_VIOLET = 0x6c71c4
  COLOR_BLUE   = 0x268bd2
  COLOR_CYAN   = 0x2aa198
  COLOR_GREEN  = 0x859900

  # base16 theme
  BASE16_BASE00 = 0x181818
  BASE16_BASE01 = 0x282828
  BASE16_BASE02 = 0x383838
  BASE16_BASE03 = 0x585858
  BASE16_BASE04 = 0xb8b8b8
  BASE16_BASE05 = 0xd8d8d8
  BASE16_BASE06 = 0xe8e8e8
  BASE16_BASE07 = 0xf8f8f8
  BASE16_BASE08 = 0xab4642
  BASE16_BASE09 = 0xdc9656
  BASE16_BASE0A = 0xf7ca88
  BASE16_BASE0B = 0xa1b56c
  BASE16_BASE0C = 0x86c1b9
  BASE16_BASE0D = 0x7cafc2
  BASE16_BASE0E = 0xba8baf
  BASE16_BASE0F = 0xa16946

  class TestApp < Application
    def initialize(argv = [])
      super(argv)
    end

    def add_buffer_to_frame(buffer)
    end

  end

  class Frame
    attr_accessor :view_win, :echo_win, :tk
    attr_accessor :echo_message
    attr_accessor :edit_win
    def initialize(buffer)
      @view_win = Scintilla::TestScintilla.new
      @echo_win = Scintilla::TestScintilla.new
      @edit_win = Mrbmacs::EditWindow.new(self, buffer, 0, 0, 0, 0)
    end

    def waitkey(win)
    end

    def strfkey(key)
    end

    def echo_set_prompt(prompt)
    end

    def echo_gets(prompt, text = "", &block)
      if $test_echo_gets[:call_block] == true
        list, len = block.call($test_echo_gets[:input_text])
        $test_echo_gets[:output_text]
      else
        $test_echo_gets[:output_text]
      end
    end

    def echo_puts(text)
      @echo_message = text
    end

    def modeline(app)
    end

    def exit
    end
  end

  class EditWindow
    def initialize(frame, buffer, x1, y1, width, height)
    end
  end
end

#class << Curses
#  [
#    :initscr, :raw, :curs_set, :newwin, :wbkgd, :wrefresh
#    ].each do |name|
#    undef_method name
#    define_method(name) do |*args|
#    end
#  end
#end

module Scintilla
  Scintilla::PLATFORM = :TEST
  class TestScintilla < ScintillaBase
    attr_accessor :pos
    attr_accessor :messages
    attr_accessor :test_return
    def initialize
      @pos = 0
      @messages = []
      @test_return = {}
    end

    def send_message(id, *args)
      @messages.push id
      if @test_return[id] != nil
        return @test_return[id]
      else
        return 0
      end
    end

    def resize_window(height, width)
    end

    def move_window(x, y)
    end

    def refresh
    end

#    def sci_set_docpointer(doc)
#    end

#    def sci_set_lexer_language(lang)
#    end

    def send_key(key, mod_shift, mod_ctrl, mod_alt)
    end

#   def sci_get_current_pos()
#      @pos
#    end

    def sci_get_curline()
      []
    end

  end
end

class TermKey
  attr_accessor :key_buffer
  class Key
    attr_accessor :key_str
    def initialize(key = nil)
      if key != nil
        @code = key.chr
        @type = TermKey::TYPE_UNICODE
        @modifiers = 0
        @key_str = key
      else
        @code = 0
        @type = TermKey::TYPE_UNKNOWN_CSI
        @modifiers = 0
        @key_str = ""
      end
    end

    def modifiers
      @modifiers
    end

    def type
      @type
    end

    def code
      @code
    end

  end

  def initialize(fd, flag)
    @key_buffer = []
  end

  def waitkey
    if @key_buffer.size > 0
      [TermKey::RES_KEY, TermKey::Key.new(@key_buffer.shift)]
    else
      [TermKey::RES_NONE, TermKey::Key.new]
    end
  end

  def strfkey(key, flag)
    key.key_str
  end

  def buffer_remaining
    0
  end

  def buffer_size
    0
  end
end

def exit
end