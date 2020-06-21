assert('get_mode_by_suffix') do
  assert_equal("bash", Mrbmacs::Mode.get_mode_by_suffix(".sh"))
  assert_equal("cpp", Mrbmacs::Mode.get_mode_by_suffix(".c"))
  assert_equal("cpp", Mrbmacs::Mode.get_mode_by_suffix(".h"))
  assert_equal("cpp", Mrbmacs::Mode.get_mode_by_suffix(".cpp"))
  assert_equal("cpp", Mrbmacs::Mode.get_mode_by_suffix(".cxx"))
  assert_equal("css", Mrbmacs::Mode.get_mode_by_suffix(".css"))
  assert_equal("diff", Mrbmacs::Mode.get_mode_by_suffix(".diff"))
  assert_equal("fundamental", Mrbmacs::Mode.get_mode_by_suffix(".txt"))
  assert_equal("fundamental", Mrbmacs::Mode.get_mode_by_suffix(""))
  assert_equal("fundamental", Mrbmacs::Mode.get_mode_by_suffix(".hoge"))
  assert_equal("go", Mrbmacs::Mode.get_mode_by_suffix(".go"))
  assert_equal("haskell", Mrbmacs::Mode.get_mode_by_suffix(".hs"))
  assert_equal("html", Mrbmacs::Mode.get_mode_by_suffix(".html"))
  assert_equal("html", Mrbmacs::Mode.get_mode_by_suffix(".htm"))
  assert_equal("java", Mrbmacs::Mode.get_mode_by_suffix(".java"))
  assert_equal("javascript", Mrbmacs::Mode.get_mode_by_suffix(".js"))
  assert_equal("json", Mrbmacs::Mode.get_mode_by_suffix(".json"))
  assert_equal("markdown", Mrbmacs::Mode.get_mode_by_suffix(".md"))
  assert_equal("perl", Mrbmacs::Mode.get_mode_by_suffix(".pl"))
  assert_equal("python", Mrbmacs::Mode.get_mode_by_suffix(".py"))
  assert_equal("r", Mrbmacs::Mode.get_mode_by_suffix(".r"))
  assert_equal("ruby", Mrbmacs::Mode.get_mode_by_suffix(".rb"))
  assert_equal("rust", Mrbmacs::Mode.get_mode_by_suffix(".rs"))
  assert_equal("latex", Mrbmacs::Mode.get_mode_by_suffix(".tex"))
  assert_equal("yaml", Mrbmacs::Mode.get_mode_by_suffix(".yaml"))
  assert_equal("yaml", Mrbmacs::Mode.get_mode_by_suffix(".yml"))
  assert_equal("lisp", Mrbmacs::Mode.get_mode_by_suffix(".lisp"))
end

assert('get_mode_by_filename') do
  assert_equal("bash", Mrbmacs::Mode.get_mode_by_filename("test.sh"))
  assert_equal("cpp", Mrbmacs::Mode.get_mode_by_filename("/foo/bar/baz.c"))
  assert_equal("make", Mrbmacs::Mode.get_mode_by_filename("Makefile"))
  assert_equal("ruby", Mrbmacs::Mode.get_mode_by_filename("Rakefile"))
  assert_equal("latex", Mrbmacs::Mode.get_mode_by_filename("test.tex"))
  assert_equal("lisp", Mrbmacs::Mode.get_mode_by_filename(".lisp"))
end

assert('set_mode_by_filename') do
  assert_equal("ruby", Mrbmacs::Mode.set_mode_by_filename("hoge.rb").name)
  assert_equal("ruby", Mrbmacs::Mode.set_mode_by_filename("foo.bar.rb").name)
  assert_equal("css", Mrbmacs::Mode.set_mode_by_filename("hogehoge.css").name)
  assert_equal("diff", Mrbmacs::Mode.set_mode_by_filename("hogehoge.diff").name)
  assert_equal("make", Mrbmacs::Mode.set_mode_by_filename("Makefile").name)
  assert_equal("latex", Mrbmacs::Mode.set_mode_by_filename("test.tex").name)
  assert_equal("lisp", Mrbmacs::Mode.set_mode_by_filename("test.lisp").name)
  skip "bug of mruby-io" if true
  assert_equal("ruby", Mrbmacs::Mode.set_mode_by_filename(".hogehoge.rb").name)
end

assert('mode Class') do
  assert_equal Mrbmacs::RubyMode, Mrbmacs::Mode.set_mode_by_filename("a.rb").class
end
