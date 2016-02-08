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

assert('set-mark') do
  app = setup
  assert_equal(nil, app.mark_pos)
  Mrbmacs::set_mark(app)
  assert_equal(0, app.mark_pos)
  ret = Mrbmacs::copy_region(app)
  assert_equal(nil, app.mark_pos)
end

assert('copy-region') do
  app = setup
  org_text = app.frame.view_win.sci_get_text(app.frame.view_win.sci_get_length+1)
  Mrbmacs::copy_region(app)
  text = app.frame.view_win.sci_get_text(app.frame.view_win.sci_get_length+1)
  assert_equal(org_text, text)
end

assert('cut-region') do
  app = setup
  win = app.frame.view_win
  org_text = win.sci_get_text(win.sci_get_length + 1)
  Mrbmacs::cut_region(app)
  text = win.sci_get_text(win.sci_get_length + 1)
  assert_equal(org_text, text)

  # cut all text
  Mrbmacs::set_mark(app)
  win.sci_set_current_pos(win.sci_get_length + 1)
  Mrbmacs::cut_region(app)
  text = win.sci_get_text(win.sci_get_length + 1)
  assert_equal("", text)
end

assert('kill-line 1') do
  app = setup
  win = app.frame.view_win
  org_text = win.sci_get_text(win.sci_get_length + 1)
  Mrbmacs::kill_line(app)
  text = win.sci_get_text(win.sci_get_length + 1)
  assert_equal("", text.split("\n")[0])
  assert_equal(org_text.split("\n")[1], text.split("\n")[1])
end  

assert('kill-line 2') do
  app = setup
  win = app.frame.view_win
  org_text = win.sci_get_text(win.sci_get_length + 1)

  win.sci_set_current_pos(5)
  Mrbmacs::kill_line(app)
  text = win.sci_get_text(win.sci_get_length + 1)
  assert_equal(org_text.split("\n")[0][0..4], text.split("\n")[0])
end

assert('beginning-of-buffer') do
  app = setup
  win = app.frame.view_win

  Mrbmacs::beginning_of_buffer(app)
  assert_equal(0, win.sci_get_current_pos)
  win.sci_set_current_pos(win.sci_get_length + 1)  
  Mrbmacs::beginning_of_buffer(app)
  assert_equal(0, win.sci_get_current_pos)
end

assert('end-of-buffer') do
  app = setup
  win = app.frame.view_win

  Mrbmacs::end_of_buffer(app)
  assert_equal(win.sci_get_length, win.sci_get_current_pos)
end
  
assert('newline') do
  app = setup
  win = app.frame.view_win
  org_text = win.sci_get_text(win.sci_get_length + 1)

  Mrbmacs::newline(app)
  text = win.sci_get_text(win.sci_get_length + 1)

  assert_equal("\n" + org_text, text)
end

assert('keyboard-quit') do
  app = setup
  win = app.frame.view_win
  org_text = win.sci_get_text(win.sci_get_length + 1)
  Mrbmacs::set_mark(app)
  assert_equal(0, app.mark_pos)
  Mrbmacs::keyboard_quit(app)
  assert_equal(nil, app.mark_pos)
end