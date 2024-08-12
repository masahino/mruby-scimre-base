require "#{File.dirname(__FILE__)}/test_helper.rb"

assert('change mode') do
  app = Mrbmacs::ApplicationTest.new
  test_file = "#{File.dirname(__FILE__)}/test.input"
  app.find_file(test_file)
  assert_equal 'fundamental', app.current_buffer.mode.name
  app.ruby_mode
  assert_equal 'ruby', app.current_buffer.mode.name
end

assert('respond_to_missing?') do
  app = Mrbmacs::ApplicationTest.new

  # Test responding to existing methods
  assert_true app.respond_to?(:SCI_PRESS)
  assert_true app.respond_to?(:SCI_RELEASE)
  assert_true app.respond_to?(:sci_foobar)
  assert_true app.respond_to?(:ruby_mode)

  # Test non-existent methods
  assert_false app.respond_to?(:non_existent_method)
  assert_false app.respond_to?(:random_method)
end
