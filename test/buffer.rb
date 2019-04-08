require File.dirname(__FILE__) + '/test_helper.rb'

def setup_buffers
  app = Mrbmacs::Application.new
  buf1 = Mrbmacs::Buffer.new("/foo/bar/foo.rb", [])
  app.buffer_list.push(buf1)
  buf2 = Mrbmacs::Buffer.new("/foo/bar/bar.rb", app.buffer_list)
  app.buffer_list.push(buf2)
  buf3 = Mrbmacs::Buffer.new("/foo/bar/baz.rb", app.buffer_list)
  app.buffer_list.push(buf3)
  app.current_buffer = buf3
  app
end

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
  app = setup_buffers
  app.switch_to_buffer("bar.rb")
  assert_equal(Scintilla::SCI_GOTOPOS, app.frame.view_win.messages.pop)
  assert_equal("bar.rb", app.current_buffer.name)
  assert_equal("bar.rb", app.buffer_list.last.name)
end

assert('switch-to-buffer (not exist)') do
  app = setup_buffers
  app.switch_to_buffer("xxx")
  assert_equal("baz.rb", app.current_buffer.name)
  assert_equal("baz.rb", app.buffer_list.last.name)
end

assert('kill-buffer (current_buffer)') do
  app = setup_buffers
  app.kill_buffer("baz.rb")
  assert_equal(3, app.buffer_list.size)
  assert_equal("bar.rb", app.buffer_list.last.name)
end

assert('kill-buffer (not current_buffer)') do
  app = setup_buffers
  app.kill_buffer("foo.rb")
  assert_equal(3, app.buffer_list.size)
  assert_equal("baz.rb", app.buffer_list.last.name)
end

assert('kill-buffer (all buffers)') do
  app = setup_buffers
  app.kill_buffer("foo.rb")
  app.kill_buffer("bar.rb")
  app.kill_buffer("baz.rb")
  app.kill_buffer("*scratch*")
  assert_equal(1, app.buffer_list.size)
  assert_equal("*scratch*", app.buffer_list.last.name)
end

assert('kill-buffer (not exist)') do
  app = setup_buffers
  app.kill_buffer("xxx")
  assert_equal(4, app.buffer_list.size)
end