require File.dirname(__FILE__) + '/test_helper.rb'

assert('Modeline.new') do
  modeline = Mrbmacs::Modeline.new
  assert_equal '(#{modeline_encoding}-#{modeline_eol}):#{modeline_modified} #{modeline_buffername} #{modeline_pos}    (#{modeline_vcinfo})    [#{modeline_modename}]    [#{modeline_additional_info}]', modeline.format
end

assert('modeline_str') do
  app = Mrbmacs::TestApp.new
  assert_equal '(', app.modeline_str[0]
end

assert('modeline_format') do
  app = Mrbmacs::TestApp.new
  app.modeline_format 'hoge'
  assert_equal 'hoge', app.modeline.format
  app.modeline_format '#{modeline_eol}'
  assert_equal '#{modeline_eol}', app.modeline.format
end

assert('modeline_enoding') do
  app = Mrbmacs::TestApp.new
  assert_equal 'utf-8', app.modeline_encoding
end

assert('modeline_eol') do
  app = Mrbmacs::TestApp.new
  assert_equal 'CRLF', app.modeline_eol
end

assert('modelne_buffername') do
  app = Mrbmacs::TestApp.new
  assert_equal '*scratch*', app.modeline_buffername
end

assert('modeline_pos') do
  app = Mrbmacs::TestApp.new
  assert_equal '(1,1)', app.modeline_pos
end

assert('modeline_modename') do
  app = Mrbmacs::TestApp.new
  assert_equal 'default', app.modeline_modename
end

assert('modeline_additional_info') do
  app = Mrbmacs::TestApp.new
  assert_equal '', app.modeline_additional_info
end

assert('modeline_vcinfo') do
  app = Mrbmacs::TestApp.new
  assert_equal 'Git:', app.modeline_vcinfo[0..3]
end