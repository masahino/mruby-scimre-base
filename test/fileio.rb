$separator = File::ALT_SEPARATOR || File::SEPARATOR
require File.dirname(__FILE__) + $separator + 'test_helper.rb'

assert('insert-file nil') do
  app = Mrbmacs::TestApp.new()
  app.insert_file()
  assert_equal "no match", app.frame.echo_message
end

assert('insert-file echo_gets') do
  app = Mrbmacs::TestApp.new()
  $test_echo_gets[:call_block] = true
  $test_echo_gets[:output_text] = File.dirname(__FILE__) + $separator + "test.input"
  app.insert_file()
  assert_equal nil, app.frame.echo_message
  assert_equal(Scintilla::SCI_INSERTTEXT, app.frame.view_win.messages.pop)
end

assert('insert-file') do
  app = Mrbmacs::TestApp.new()
  test_file = File.dirname(__FILE__) + $separator + "test.input"
  app.insert_file(test_file)
  assert_equal(Scintilla::SCI_INSERTTEXT, app.frame.view_win.messages.pop)
end

assert('insert-file new buffer') do
  app = Mrbmacs::TestApp.new()
  app.find_file("hoge")
  test_file = File.dirname(__FILE__) + $separator + "test.input"
  app.insert_file(test_file)
  assert_equal(Scintilla::SCI_INSERTTEXT, app.frame.view_win.messages.pop)
end

assert('write-file') do
  app = Mrbmacs::TestApp.new()
  test_file = File.dirname(__FILE__) + $separator + "test.output"
  app.write_file(test_file)
  assert_equal(test_file, app.current_buffer.filename)
end

assert('write-file 2') do
  app = Mrbmacs::TestApp.new()
  $test_echo_gets[:output_text] = File.dirname(__FILE__) + $separator + "test2.output"
  app.write_file()
  assert_equal($test_echo_gets[:output_text], app.current_buffer.filename)
end

assert('write-file 3') do
  app = Mrbmacs::TestApp.new()
  $test_echo_gets[:call_block] = true
  $test_echo_gets[:input_text] = File.dirname(__FILE__) + $separator + "hoge"
  $test_echo_gets[:output_text] = File.dirname(__FILE__) + $separator + "test3.output"
  app.write_file()
  assert_equal($test_echo_gets[:output_text], app.current_buffer.filename)
end

assert('Mrbmacs::dir_glob 1') do
  file_list, len = Mrbmacs::dir_glob(File.dirname(__FILE__) + $separator)
  $stderr.puts File.dirname(__FILE__) + $separator
  n = `ls #{File.dirname(__FILE__)}`.split(/\R/).length
  assert_equal(n, file_list.length)
  assert_equal(0, len)
end

assert('Mrbmacs::dir_glob 2') do
  file_list, len = Mrbmacs::dir_glob(File.dirname(__FILE__) + $separator + "test-u")
  assert_equal(3, file_list.length)
  assert_equal(6, len)
  file_list, len = Mrbmacs::dir_glob(File.dirname(__FILE__) + $separator + "not_exist")
  assert_equal(0, file_list.length)
  assert_equal(9, len)
end
