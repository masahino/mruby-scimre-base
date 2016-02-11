assert('get_mode_by_suffix') do
  assert_equal("ruby", Mrbmacs::Mode.get_mode_by_suffix(".rb"))
  assert_equal("cpp", Mrbmacs::Mode.get_mode_by_suffix(".c"))
  assert_equal("cpp", Mrbmacs::Mode.get_mode_by_suffix(".h"))
  assert_equal("cpp", Mrbmacs::Mode.get_mode_by_suffix(".cpp"))
  assert_equal("cpp", Mrbmacs::Mode.get_mode_by_suffix(".cxx"))
  assert_equal("markdown", Mrbmacs::Mode.get_mode_by_suffix(".md"))
  assert_equal("fundamental", Mrbmacs::Mode.get_mode_by_suffix(".txt"))
  assert_equal("html", Mrbmacs::Mode.get_mode_by_suffix(".html"))
  assert_equal("html", Mrbmacs::Mode.get_mode_by_suffix(".htm"))
  assert_equal("bash", Mrbmacs::Mode.get_mode_by_suffix(".sh"))
  assert_equal("fundamental", Mrbmacs::Mode.get_mode_by_suffix(""))
  assert_equal("fundamental", Mrbmacs::Mode.get_mode_by_suffix(".hoge"))
end

assert('mode Class') do
  Mrbmacs::Mode.set_mode_by_filename("a.rb").class == Mrbmacs::RubyMode
end
