module Mrbmacs
  class Application
    def message(text)
      @frame.echo_puts text
    end
  end
end