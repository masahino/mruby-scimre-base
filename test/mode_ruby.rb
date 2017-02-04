assert('get_candidates 1') do
  mode = Mrbmacs::RubyMode.new
  assert_equal(['and'], mode.get_candidates("and"))
end

assert('get_candidates String') do
  mode = Mrbmacs::RubyMode.new
  methods = String.instance_methods.map{|m| m.to_s}.sort
  assert_equal(methods, mode.get_candidates('"test".'))
end

assert('get_candidates Regexp') do
  mode = Mrbmacs::RubyMode.new
  methods = Regexp.instance_methods.map{|m| m.to_s}.sort
  assert_equal(methods, mode.get_candidates('/hoge/.'))
end

assert('get_candidates Hash or Proc') do
  mode = Mrbmacs::RubyMode.new
  methods = Proc.instance_methods.map{|m| m.to_s}
  methods |= Hash.instance_methods.map{|m| m.to_s}.sort
  assert_equal(methods, mode.get_candidates('{:a => 1, :b => 2}.'))
end

assert('get_candidates Symbol') do
  mode = Mrbmacs::RubyMode.new
  assert_equal([':MRUBY_VERSION'], mode.get_candidates(':MRUBY_V'))
end

assert('get_candidates Absolute Constant or class methods') do
  mode = Mrbmacs::RubyMode.new
  assert_equal(['::MRUBY_VERSION'], mode.get_candidates('::MRUBY_V'))
end

assert('get_candidates Constant or class methods') do
  mode = Mrbmacs::RubyMode.new
  candidates = Mrbmacs::Mode.constants.collect{|c| c.to_s}
  candidates |= Mrbmacs::Mode.methods.collect{|m| m.to_s}.sort
  assert_equal(candidates, mode.get_candidates('Mrbmacs::Mode::'))
end

assert('get_candidates Symbol') do
  mode = Mrbmacs::RubyMode.new
  candidates = :test.methods.collect{|m| m.to_s}.sort
  assert_equal(candidates, mode.get_candidates(':test.'))
end

assert('get_candidates Numeric') do
  mode = Mrbmacs::RubyMode.new
  candidates = 1.methods.collect{|m| m.to_s}.sort
  assert_equal(candidates, mode.get_candidates('1.'))
end

assert('get_candidates Numeric(0xFFFF)') do
  mode = Mrbmacs::RubyMode.new
  candidates = 1.methods.collect{|m| m.to_s}.sort
  assert_equal(candidates, mode.get_candidates('0xff.'))
end

assert('get_candidates global var') do
  mode = Mrbmacs::RubyMode.new
  assert_equal(['$stderr', '$stdin', '$stdout'], mode.get_candidates('$std'))
end

assert('get_candidates variable.func or func.func') do
  mode = Mrbmacs::RubyMode.new
  candidates = $stderr.methods.collect{|m| m.to_s}.sort
  assert_equal(candidates, mode.get_candidates("$stderr.put"))
end

assert('get_candidates unknown') do
  mode = Mrbmacs::RubyMode.new
#  candidates = Symbol.all_symbols.collect{|s| ":" + s.id2name}
  assert_equal(Array, mode.get_candidates('Mrbmacs::').class)
end
