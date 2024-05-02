assert('JsonMode::end_of_block?') do
  mode = Mrbmacs::JsonMode.new
  assert_equal(true, mode.end_of_block?('}'))
  assert_equal(true, mode.end_of_block?(' }'))
  assert_equal(true, mode.end_of_block?('} '))
  assert_equal(true, mode.end_of_block?(']'))
  assert_equal(true, mode.end_of_block?('},'))
  assert_equal(true, mode.end_of_block?('],'))
  assert_equal(false, mode.end_of_block?('hoge'))
end