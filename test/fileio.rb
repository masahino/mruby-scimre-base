require File.dirname(__FILE__) + '/test_helper.rb'

assert('insert-file nil') do
  app = Mrbmacs::Application.new()
  app.insert_file()
  assert_equal "no match", app.frame.echo_message
end

assert('insert-file') do
  app = Mrbmacs::Application.new()
  test_file = File.dirname(__FILE__) + "/test.input"
  app.insert_file(test_file)
  assert_equal(Scintilla::SCI_INSERTTEXT, app.frame.view_win.messages.pop)
end


assert('write-file') do
  app = Mrbmacs::Application.new()
  test_file = File.dirname(__FILE__) + "/test.output"
  app.write_file(test_file)
  assert_equal(test_file, app.current_buffer.filename)
end
