# test module for mruby-mrbmacs-base
$test_echo_gets = {
  call_block: false,
  input_text: 'test',
  output_text: 'test'
}
$test_file_name = 'test'

module Mrbmacs
  # Application class for test
  class ApplicationTest < Application
    attr_accessor :mark_pos, :modeline

    def initialize(argv = [])
      super(argv)
    end

    def add_buffer_to_frame(buffer)
      # dummy
    end

    def read_file_name(_prompt, _directory, _default_name = nil)
      $test_file_name
    end
  end

  # Frame class for test
  class Frame < FrameBase
    attr_accessor :view_win, :echo_win, :tk, :echo_message, :edit_win, :mode_win

    def initialize(buffer)
      @echo_win = Scintilla::ScintillaTest.new
      @edit_win = Mrbmacs::EditWindowTest.new(self, buffer, 0, 0, 40, 40)
      @view_win = @edit_win.sci
      @edit_win_list = [@edit_win]
      @mode_win = @edit_win.mode_win
    end

    def new_editwin(buffer, x, y, width, height)
      Mrbmacs::EditWindowTest.new(self, buffer, x, y, width, height)
    end

    def waitkey(win)
    end

    def strfkey(key)
    end

    def echo_set_prompt(prompt)
    end

    def echo_gets(prompt, text = '', &block)
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

    def modeline(app, win = @mode_win)
    end

    def exit
    end
  end

  # EditWindow class for test
  class EditWindowTest < EditWindow
    def initialize(frame, buffer, x1, y1, width, height)
      @sci = Scintilla::ScintillaTest.new
      @buffer = buffer
      @x1 = x1
      @y1 = y1
      @x2 = x1 + width - 1
      @y2 = y1 + height - 1
      @width = width
      @height = height
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
  # Scniailla class for test
  class ScintillaTest < ScintillaBase
    attr_accessor :pos, :messages, :test_return
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

    def send_message_get_text(_message, length)
      send_message(Scintilla::SCI_GETTEXT, [length])
    end

    def send_message_get_line(line)
      send_message(Scintilla::SCI_GETLINE, [line])
    end

    def send_message_get_text(_message, _wparam)
      ''
      # dummy
    end

    def send_message_set_docpointer(id, wparam)
      # dummy
    end

    def send_message_get_docpointer(wparam)
      # dummy
    end

    def resize_window(height, width)
      # dummy
    end

    def move_window(x, y)
      # dummy
    end

    def refresh
      # dummy
    end

    def send_key(key, mod_shift, mod_ctrl, mod_alt)
      # dummy
    end

#   def sci_get_current_pos()
#      @pos
#    end

    def sci_get_curline
      []
    end

    def sci_set_lexer_language(lang)
      # dummy
    end
  end
end

# TermKey class for test
class TermKey
  attr_accessor :key_buffer

  # Key
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
        @key_str = ''
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

  def initialize(_fd, _flag)
    @key_buffer = []
  end

  def waitkey
    if @key_buffer.size > 0
      [TermKey::RES_KEY, TermKey::Key.new(@key_buffer.shift)]
    else
      [TermKey::RES_NONE, TermKey::Key.new]
    end
  end

  def strfkey(key, _flag)
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
  # dummy
end
