class TestApp
  attr_accessor :frame, :mark_pos
  attr_accessor :current_buffer, :buffer_list, :prev_buffer
  attr_accessor :mode
  attr_accessor :theme
  attr_accessor :file_encodings
end

class TestFrame
  attr_accessor :view_win, :echo_win, :tk
end

def setup
  app = TestApp.new
  sci = nil
  test_text = File.open(File.dirname(__FILE__) + "/test.input").read

  case Scintilla::PLATFORM
  when :CURSES
    Curses::initscr
    sci = Scintilla::ScinTerm.new
  when :GTK
    sci = nil
  else
    sci = nil
  end
  if sci != nil
    sci.sci_set_text(test_text)
  end
  frame = TestFrame.new
  frame.view_win = sci
  app.frame = frame
  app.mode = Mrbmacs::Mode.new
  app
end

assert('insert-file 1') do
  app = setup
  win = app.frame.view_win
  org_text = win.sci_get_text(win.sci_get_length + 1)
  test_file = File.dirname(__FILE__) + "/test.input"
  Mrbmacs::insert_file(app, test_file)
  text = win.sci_get_text(win.sci_get_length + 1)
  assert_equal(org_text + org_text, text)
end

assert('insert-file 2') do
  app = setup
  win = app.frame.view_win
  org_text = win.sci_get_text(win.sci_get_length + 1)
  test_file = File.dirname(__FILE__) + "/test.input"
  win.sci_set_current_pos(5)
  Mrbmacs::insert_file(app, test_file)
  text = win.sci_get_text(win.sci_get_length + 1)
  assert_equal(org_text[0..4] + org_text + org_text[5..-1], text)
end
