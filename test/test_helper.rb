# test module for mruby-mrbmacs-base
$test_echo_gets = {
  :call_block => false,
  :input_text => "test",
  :output_text => "test"
}
module Mrbmacs
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
      @echo_win = Scintilla::TestScintilla.new
      @edit_win = Mrbmacs::EditWindow.new(self, buffer, 0, 0, 0, 0)
      @view_win = @edit_win.sci
      @edit_win_list = [@edit_win]
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
      @sci = Scintilla::TestScintilla.new
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
