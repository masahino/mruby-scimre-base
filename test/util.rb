assert('Mrbmacs#common_prefix') do
  assert_equal nil, Mrbmacs.common_prefix([])

  assert_equal 'abc', Mrbmacs.common_prefix(['abcxyz', 'abc123', 'abcdonotuse'])

  assert_nil Mrbmacs.common_prefix(['apple', 'banana', 'cherry'])

  assert_equal 'apple', Mrbmacs.common_prefix(['apple', 'apple', 'apple'])

  assert_nil Mrbmacs.common_prefix(['', 'banana', ''])
  assert_equal 'a', Mrbmacs.common_prefix(['apple', 'a', 'apricot'])
  assert_nil Mrbmacs.common_prefix(['apple', '', 'banana'])
end
