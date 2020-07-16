module Mrbmacs
  class Extension
    attr_accessor :config
    attr_accessor :data
    def initialize
      @config = {}
      @data = {}
    end

    def self.subclasses
      subclasses = []
      ObjectSpace.each_object(Class) {|klass| subclasses << klass if klass.superclass == self}
      subclasses
    end
  end
end