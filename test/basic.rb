require File.dirname(__FILE__) + '/test_helper.rb'

assert('set-mark') do
  app = Mrbmacs::Application.new("")
  assert_equal(nil, app.mark_pos)
  app.set_mark()
  assert_equal(0, app.mark_pos)
  ret = app.copy_region()
  assert_equal(nil, app.mark_pos)
end

assert('copy-region') do
  app = Mrbmacs::Application.new("")
  app.set_mark()
  app.copy_region()
  assert_equal(Scintilla::SCI_COPYRANGE, app.frame.view_win.messages.pop)
  assert_equal(nil, app.mark_pos)
end

assert('cut-region') do
  app = Mrbmacs::Application.new("")
  app.cut_region()
  assert_equal(nil, app.mark_pos)
  # cut all text
  app.set_mark()
  app.cut_region()
  assert_equal(nil, app.mark_pos)
end

assert('kill-line') do
  app = Mrbmacs::Application.new("")
  app.kill_line()
  assert_equal(Scintilla::SCI_DELETERANGE, app.frame.view_win.messages.pop)
  app.frame.view_win.test_return[Scintilla::SCI_GETLINE] = "\n"
  app.kill_line()
  assert_equal(Scintilla::SCI_LINECUT, app.frame.view_win.messages.pop)
end  

assert('beginning-of-buffer') do
  app = Mrbmacs::Application.new("")
  app.beginning_of_buffer()
  assert_equal(Scintilla::SCI_DOCUMENTSTART, app.frame.view_win.messages.pop)
end

assert('end-of-buffer') do
  app = Mrbmacs::Application.new("")
  app.end_of_buffer()
  assert_equal(Scintilla::SCI_DOCUMENTEND, app.frame.view_win.messages.pop)
end
  
assert('newline') do
  app = Mrbmacs::Application.new("")
  win = app.frame.view_win
  app.newline()
  assert_equal(Scintilla::SCI_NEWLINE, win.messages.pop)
end

assert('keyboard-quit') do
  app = Mrbmacs::Application.new("")
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

assert('indent') do
  app = Mrbmacs::Application.new
  win = app.frame.view_win
  win.test_return[Scintilla::SCI_AUTOCACTIVE] = 1
  app.indent
  assert_equal(Scintilla::SCI_VCHOME, app.frame.view_win.messages.pop)
  win.test_return[Scintilla::SCI_AUTOCACTIVE] = 0
  app.indent
  assert_equal(Scintilla::SCI_GETCOLUMN, app.frame.view_win.messages.pop)
end

assert('sava-buffers-kill-terminal') do
  app = Mrbmacs::Application.new
  assert_nil(app.save_buffers_kill_terminal)
end

assert('keyboard-quit') do
  app = Mrbmacs::Application.new
  app.keyboard_quit
  assert_nil(app.mark_pos)
end

assert('clear-rectangle') do
  app = Mrbmacs::Application.new
  app.mark_pos = nil
  app.clear_rectangle
  assert_equal(Scintilla::SCI_SETSELECTIONMODE, app.frame.view_win.messages.pop)
  app.mark_pos = 1
  app.clear_rectangle
  assert_equal(Scintilla::SCI_REPLACESEL, app.frame.view_win.messages.pop)
  assert_nil(app.mark_pos)
end

assert('clear-rectangle') do
  app = Mrbmacs::Application.new
  app.mark_pos = nil
  app.delete_rectangle
  assert_equal(Scintilla::SCI_SETSELECTIONMODE, app.frame.view_win.messages.pop)
  app.mark_pos = 1
  app.delete_rectangle
  assert_equal(Scintilla::SCI_REPLACESEL, app.frame.view_win.messages.pop)
  assert_nil(app.mark_pos)
end
