require File.dirname(__FILE__) + '/test_helper.rb'

assert('auto_close extension') do
  app = Mrbmacs::TestApp.new
  assert_equal 1, app.sci_handler[Scintilla::SCN_CHARADDED].size
  assert_equal 10, app.sci_handler[Scintilla::SCN_CHARADDED].last.priority
end
