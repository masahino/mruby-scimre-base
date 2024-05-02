assert('Mode.add_keybind') do
  mode = Mrbmacs::Mode.new
  mode.add_keybind('x', 'hoge')
end
