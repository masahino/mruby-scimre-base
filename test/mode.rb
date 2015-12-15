assert('Suffix') do
  Mrbmacs::Mode.get_mode_by_suffix(".rb")   == "ruby"
  Mrbmacs::Mode.get_mode_by_suffix(".c")    == "cpp"
  Mrbmacs::Mode.get_mode_by_suffix(".h")    == "cpp"
  Mrbmacs::Mode.get_mode_by_suffix(".cpp")  == "cpp"
  Mrbmacs::Mode.get_mode_by_suffix(".cxx")  == "cpp"
  Mrbmacs::Mode.get_mode_by_suffix(".md")   == "markdown"
  Mrbmacs::Mode.get_mode_by_suffix(".txt")  == "fundamental"
  Mrbmacs::Mode.get_mode_by_suffix("")      == "fundamental"
  Mrbmacs::Mode.get_mode_by_suffix(".hoge") == "fundamental"
end

assert('mode Class') do
  Mrbmacs::Mode.set_mode_by_filename("a.rb").class == Mrbmacs::RubyMode
end
