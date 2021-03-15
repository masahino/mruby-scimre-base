require File.dirname(__FILE__) + '/test_helper.rb'

assert('get_mode_str') do
  app = Mrbmacs::ApplicationTest.new
  assert_equal "(",
  app.frame.get_mode_str(app)[0]
end

assert('set_theme') do
  theme = Mrbmacs::SolarizedDarkTheme.new
  frame = Mrbmacs::Frame.new(nil)
  frame.set_theme(theme)
  assert_equal Scintilla::SCI_SETSELBACK, frame.view_win.messages.pop
end