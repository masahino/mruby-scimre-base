assert('Suffix') do
  Scimre::Mode.get_mode_by_suffix(".rb")   == "ruby"
  Scimre::Mode.get_mode_by_suffix(".c")    == "cpp"
  Scimre::Mode.get_mode_by_suffix(".h")    == "cpp"
  Scimre::Mode.get_mode_by_suffix(".cpp")  == "cpp"
  Scimre::Mode.get_mode_by_suffix(".cxx")  == "cpp"
  Scimre::Mode.get_mode_by_suffix(".md")   == "markdown"
  Scimre::Mode.get_mode_by_suffix(".txt")  == "fundamental"
  Scimre::Mode.get_mode_by_suffix("")      == "fundamental"
  Scimre::Mode.get_mode_by_suffix(".hoge") == "fundamental"
end

assert('mode Class') do
  Scimre::Mode.set_mode_by_filename("a.rb").class == Scimre::RubyMode
end
