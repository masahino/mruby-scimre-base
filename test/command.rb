require File.dirname(__FILE__) + '/test_helper.rb'

assert('change mode') do
  app = Mrbmacs::ApplicationTest.new
  test_file = File.dirname(__FILE__) + "/test.input"
  app.find_file(test_file)
  assert_equal "fundamental", app.current_buffer.mode.name
  app.ruby_mode
  assert_equal "ruby", app.current_buffer.mode.name
end
