assert('JsonMode::is_end_of_block') do
  mode = Mrbmacs::JsonMode.new
  assert_equal(true, mode.is_end_of_block('}'))
  assert_equal(true, mode.is_end_of_block(' }'))
  assert_equal(true, mode.is_end_of_block('} '))
  assert_equal(true, mode.is_end_of_block(']'))
  assert_equal(true, mode.is_end_of_block('},'))
  assert_equal(true, mode.is_end_of_block('],'))
  assert_equal(false, mode.is_end_of_block('hoge'))
end