assert('end_of_block?') do
  mode = Mrbmacs::CppMode.new
  assert_true(mode.end_of_block?('}'))
  assert_true(mode.end_of_block?(' }'))
  assert_true(mode.end_of_block?('} '))
  assert_false(mode.end_of_block?('hoge'))
end
