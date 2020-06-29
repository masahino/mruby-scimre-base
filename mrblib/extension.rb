module Mrbmacs
  class Extension
    attr_accessor :config
    def initialize
      @config = {}
    end

    def self.subclasses
      subclasses = []
      ObjectSpace.each_object(Class) {|klass| subclasses << klass if klass.superclass == self}
      subclasses + [self]
    end
  end
end