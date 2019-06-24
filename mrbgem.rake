MRuby::Gem::Specification.new('mruby-mrbmacs-base') do |spec|
  spec.license = 'MIT'
  spec.authors = 'masahino'
  spec.add_dependency 'mruby-scintilla-base', :github => 'masahino/mruby-scintilla-base'
  spec.add_dependency 'mruby-io'
  spec.add_dependency 'mruby-dir'
  spec.add_dependency 'mruby-eval'
  spec.add_dependency 'mruby-onig-regexp'
  spec.add_dependency 'mruby-array-ext'
  spec.add_dependency 'mruby-symbol-ext'
  spec.add_dependency 'mruby-objectspace'
  spec.add_dependency 'mruby-optparse', :github => 'fastly/mruby-optparse'
  spec.add_dependency 'mruby-logger'
  spec.add_dependency 'mruby-tempfile'
  spec.add_test_dependency 'mruby-io'
  spec.add_test_dependency 'mruby-eval'
  spec.add_test_dependency 'mruby-iconv'
  spec.add_test_dependency 'mruby-metaprog'
  spec.add_test_dependency 'mruby-require'
end
