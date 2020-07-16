require File.dirname(__FILE__) + '/test_helper.rb'

assert('key_scan') do
  app = Mrbmacs::TestApp.new
  assert_equal 'beginning-of-line', app.key_scan('C-a')
  app.current_buffer.mode.keymap['C-a'] = 'hoge'
  assert_equal 'hoge', app.key_scan('C-a')
  app.current_buffer.mode.keymap['C-b'] = Scintilla::SCI_LINESCROLLDOWN
  assert_equal 2342, app.key_scan('C-b')
end