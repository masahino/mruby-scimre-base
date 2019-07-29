MRuby::Build.new do |conf|
  toolchain :gcc
  conf.gembox 'default'

  conf.gem File.expand_path(File.dirname(__FILE__))

  conf.enable_test
  conf.enable_bintest
  conf.linker do |linker|
    linker.libraries << "stdc++"
  end
end
