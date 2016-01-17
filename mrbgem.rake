MRuby::Gem::Specification.new('mruby-mrbmacs-base') do |spec|
  spec.license = 'MIT'
  spec.authors = 'masahino'
  spec.add_dependency 'mruby-scintilla-base', :github => 'masahino/mruby-scintilla-base'
  spec.add_dependency 'mruby-io'
  spec.add_dependency 'mruby-eval'
  spec.add_test_dependency 'mruby-io'
  spec.add_test_dependency 'mruby-eval'
end
