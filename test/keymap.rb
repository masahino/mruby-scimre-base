require File.dirname(__FILE__) + '/test_helper.rb'

assert('apply_keymap') do
  app = Mrbmacs::ApplicationTest.new
  keymap = Mrbmacs::ViewKeyMap.new
  app.apply_keymap(app.frame.view_win, keymap)
  assert_equal(Scintilla::SCI_ASSIGNCMDKEY, app.frame.view_win.messages.pop)
end
