require File.dirname(__FILE__) + '/test_helper.rb'

module Mrbmacs
  class Test1Extension < Extension
  end

  class Test2Extension < Extension
  end
end

assert("subclasses") do
  app = Mrbmacs::ApplicationTest.new
  assert_equal(3, Mrbmacs::Extension.subclasses.size)
end