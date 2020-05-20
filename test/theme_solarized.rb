require File.dirname(__FILE__) + '/test_helper.rb'

assert('SolarizedDarkTheme') do
  dark = Mrbmacs::SolarizedDarkTheme.new
  assert_equal("solarized-dark", dark.name)
  assert_equal(0x969483, dark.foreground_color)
  assert_equal(0x362b00, dark.background_color)
end

assert('SolarizedLightTheme') do
  light = Mrbmacs::SolarizedLightTheme.new
  assert_equal("solarized-light", light.name)
  assert_equal(0x969583, light.foreground_color)
  assert_equal(0xe3f6fd, light.background_color)
end
