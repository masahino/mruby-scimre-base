require File.dirname(__FILE__) + '/test_helper.rb'

assert('Buffer.new') do
  app = Mrbmacs::Application.new
  buffer = Mrbmacs::Buffer.new
  assert_kind_of(Mrbmacs::Buffer, buffer)
end

assert('new buffer name') do
  app = Mrbmacs::Application.new()
  buffer1 = Mrbmacs::Buffer.new("/foo/bar/hoge.rb", [])
  assert_equal("hoge.rb", buffer1.name)
  buffer_list = [buffer1]

  buffer2 = Mrbmacs::Buffer.new("/aaa/bbb/hoge.rb", buffer_list)
  assert_equal("hoge.rb<bbb>", buffer2.name)
  buffer_list.push(buffer2)

  buffer3 = Mrbmacs::Buffer.new("/ccc/bbb/hoge.rb", buffer_list)
  assert_equal("hoge.rb<ccc/bbb>", buffer3.name)
end

assert('Buffer.get_buffer_from_name') do
  assert_nil(Mrbmacs::get_buffer_from_name([], "hoge"))
  buf1 = Mrbmacs::Buffer.new("/foo/bar/hoge.rb", [])
  buf2 = Mrbmacs::Buffer.new("/foo/bar/huga.rb", [])
  buffer_list = [buf1, buf2]
  assert_equal(buf2, Mrbmacs::get_buffer_from_name(buffer_list, "huga.rb"))
end

assert('Buffer.get_buffer_from_path') do
  assert_nil(Mrbmacs::get_buffer_from_path([], "hoge"))
  buf1 = Mrbmacs::Buffer.new("/foo/bar/hoge.rb", [])
  buf2 = Mrbmacs::Buffer.new("/foo/bar/huga.rb", [])
  buffer_list = [buf1, buf2]
  assert_equal(buf2, Mrbmacs::get_buffer_from_path(buffer_list, "/foo/bar/huga.rb"))
end

assert('switch-to-buffer') do
  app = Mrbmacs::Application.new()
  assert_equal("*scratch*", app.current_buffer.name)
  assert_equal(0, app.current_buffer.pos)
  new_buffer = Mrbmacs::Buffer.new("new")
  app.buffer_list.push(new_buffer)
  app.switch_to_buffer("new")
  assert_equal(Scintilla::SCI_GOTOPOS, app.frame.view_win.messages.pop)
end

assert('kill-buffer') do
  app = Mrbmacs::Application.new
  app.kill_buffer
end

