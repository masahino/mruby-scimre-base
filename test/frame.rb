require File.dirname(__FILE__) + '/test_helper.rb'

assert('get_mode_str') do
  app = Mrbmacs::TestApp.new
  assert_equal " (utf-8-dos):---    *scratch*           (1,1)     [default] []                  ",
  app.frame.get_mode_str(app)
end