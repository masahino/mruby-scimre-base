require "#{File.dirname(__FILE__)}#{File::SEPARATOR}test_helper.rb"

assert('insert-file nil') do
  app = Mrbmacs::ApplicationTest.new
  app.insert_file
  assert_equal 'no match', app.frame.echo_message
end

assert('insert-file') do
  app = Mrbmacs::ApplicationTest.new
  test_file = "#{File.dirname(__FILE__)}#{File::SEPARATOR}test.input"
  app.insert_file(test_file)
  assert_equal(Scintilla::SCI_GOTOPOS, app.frame.view_win.messages.pop)
end

assert('insert-file new buffer') do
  app = Mrbmacs::ApplicationTest.new
  app.find_file('hoge')
  test_file = "#{File.dirname(__FILE__)}#{File::SEPARATOR}test.input"
  app.insert_file(test_file)
  assert_equal(Scintilla::SCI_GOTOPOS, app.frame.view_win.messages.pop)
end

assert('write-file') do
  app = Mrbmacs::ApplicationTest.new
  test_file = "#{File.dirname(__FILE__)}#{File::SEPARATOR}test.output"
  app.write_file(test_file)
  assert_equal(File.expand_path(test_file), app.current_buffer.filename)
  assert_equal(File.basename(test_file), app.current_buffer.name)
end

assert('Mrbmacs::dir_glob 1') do
  file_list, len = Mrbmacs.dir_glob(File.dirname(__FILE__) + File::SEPARATOR)
  n = `ls #{File.dirname(__FILE__)}`.split(/\R/).length
  assert_equal(n, file_list.length)
  assert_equal(0, len)
end

assert('Mrbmacs::dir_glob 2') do
  file_list, len = Mrbmacs.dir_glob("#{File.dirname(__FILE__)}#{File::SEPARATOR}test-u")
  assert_equal(3, file_list.length)
  assert_equal(6, len)
  file_list, len = Mrbmacs.dir_glob("#{File.dirname(__FILE__)}#{File::SEPARATOR}not_exist")
  assert_equal(0, file_list.length)
  assert_equal(9, len)
end
