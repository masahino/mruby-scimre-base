require File.dirname(__FILE__) + '/test_helper.rb'

assert('get_mode_str') do
  app = Mrbmacs::TestApp.new
  assert_equal "(utf-8-CRLF):-- *scratch* (1,1)    ()    [default]    []",
  app.frame.get_mode_str(app)
end

assert('set_theme') do
  theme = Mrbmacs::SolarizedDarkTheme.new
  frame = Mrbmacs::Frame.new(nil)
  frame.set_theme(theme)
  assert_equal Scintilla::SCI_SETSELBACK, frame.view_win.messages.pop
end