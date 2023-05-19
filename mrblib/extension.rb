module Mrbmacs
  # Extension
  class Extension
    attr_accessor :config, :data

    def initialize
      @config = {}
      @data = {}
    end

    def self.subclasses
      subclasses = []
      ObjectSpace.each_object(Class) { |klass| subclasses << klass if klass.superclass == self }
      subclasses
    end
  end

  # Application
  class Application
    def register_extensions
      Extension.subclasses.each do |k|
        k.singleton_methods(false).each do |m|
          k.send(m, self) if m.to_s.start_with?('register_')
        end
      end
    end
  end
end
