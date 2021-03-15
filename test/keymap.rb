require File.dirname(__FILE__) + '/test_helper.rb'

assert('set_keymap_with_key') do
  app = Mrbmacs::ApplicationTest.new
  keymap = Mrbmacs::KeyMap.new
  keymap.set_keymap_with_key('X', 'hoge', app.view_win)
  assert_equal 'hoge', keymap.command_list['X']
end
