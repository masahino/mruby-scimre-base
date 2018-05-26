module Mrbmacs
  class TestApp < Application
    def initialize
    end
  end
end

class TestFrame
  attr_accessor :view_win, :echo_win, :tk
end

def setup
  app = Mrbmacs::TestApp.new
  sci = nil
  test_text = File.open(File.dirname(__FILE__) + "/test.input").read

  case Scintilla::PLATFORM
  when :CURSES
    Curses::initscr
    sci = Scintilla::ScintillaCurses.new
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
  app.current_buffer = Mrbmacs::Buffer.new
  app
end

assert('set-mark') do
  app = setup
  assert_equal(nil, app.mark_pos)
  app.set_mark()
  assert_equal(0, app.mark_pos)
  ret = app.copy_region()
  assert_equal(nil, app.mark_pos)
end

assert('copy-region') do
  app = setup
  org_text = app.frame.view_win.sci_get_text(app.frame.view_win.sci_get_length+1)
  app.copy_region()
  text = app.frame.view_win.sci_get_text(app.frame.view_win.sci_get_length+1)
  assert_equal(org_text, text)
end

assert('cut-region') do
  app = setup
  win = app.frame.view_win
  org_text = win.sci_get_text(win.sci_get_length + 1)
  app.cut_region()
  text = win.sci_get_text(win.sci_get_length + 1)
  assert_equal(org_text, text)

  # cut all text
  app.set_mark()
  win.sci_set_current_pos(win.sci_get_length + 1)
  app.cut_region()
  text = win.sci_get_text(win.sci_get_length + 1)
  assert_equal("", text)
end

assert('kill-line 1') do
  app = setup
  win = app.frame.view_win
  org_text = win.sci_get_text(win.sci_get_length + 1)
  app.kill_line()
  text = win.sci_get_text(win.sci_get_length + 1)
  assert_equal("", text.split("\n")[0])
  assert_equal(org_text.split("\n")[1], text.split("\n")[1])
end  

assert('kill-line 2') do
  app = setup
  win = app.frame.view_win
  org_text = win.sci_get_text(win.sci_get_length + 1)

  win.sci_set_current_pos(5)
  app.kill_line()
  text = win.sci_get_text(win.sci_get_length + 1)
  assert_equal(org_text.split("\n")[0][0..4], text.split("\n")[0])
end

assert('beginning-of-buffer') do
  app = setup
  win = app.frame.view_win

  app.beginning_of_buffer()
  assert_equal(0, win.sci_get_current_pos)
  win.sci_set_current_pos(win.sci_get_length + 1)  
  app.beginning_of_buffer()
  assert_equal(0, win.sci_get_current_pos)
end

assert('end-of-buffer') do
  app = setup
  win = app.frame.view_win

  app.end_of_buffer()
  assert_equal(win.sci_get_length, win.sci_get_current_pos)
end
  
assert('newline') do
  app = setup
  win = app.frame.view_win
  org_text = win.sci_get_text(win.sci_get_length + 1)

  app.newline()
  text = win.sci_get_text(win.sci_get_length + 1)

  assert_equal("\n" + org_text, text)
end

assert('keyboard-quit') do
  app = setup
  win = app.frame.view_win
  org_text = win.sci_get_text(win.sci_get_length + 1)
  app.set_mark()
  assert_equal(0, app.mark_pos)
  app.keyboard_quit()
  assert_equal(nil, app.mark_pos)
end

assert('isearch-forward') do
  assert_equal(true, Mrbmacs::Application.instance_methods.include?(:isearch_forward))
end

assert('isearch-backward') do
  assert_equal(true, Mrbmacs::Application.instance_methods.include?(:isearch_backward))
end
