require File.dirname(__FILE__) + '/test_helper.rb'

assert('switch-to-buffer') do
  app = Mrbmacs::Application.new("")
  assert_equal("*scratch*", app.current_buffer.name)
  assert_equal(0, app.current_buffer.pos)
  new_buffer = Mrbmacs::Buffer.new("new")
  app.buffer_list.push(new_buffer)
  app.switch_to_buffer("new")
  assert_equal(Scintilla::SCI_GOTOPOS, app.frame.view_win.messages.pop)
end

assert('new buffer name') do
  app = Mrbmacs::Application.new("")
  buffer1 = Mrbmacs::Buffer.new("/foo/bar/hoge.rb", [])
  assert_equal("hoge.rb", buffer1.name)
  buffer_list = [buffer1]

  buffer2 = Mrbmacs::Buffer.new("/aaa/bbb/hoge.rb", buffer_list)
  assert_equal("hoge.rb<bbb>", buffer2.name)
  buffer_list.push(buffer2)

  buffer3 = Mrbmacs::Buffer.new("/ccc/bbb/hoge.rb", buffer_list)
  assert_equal("hoge.rb<ccc/bbb>", buffer3.name)
end
