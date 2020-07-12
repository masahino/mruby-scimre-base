module Mrbmacs
  class Application
    def message(text)
      @logger.debug text
      @frame.echo_puts text
    end
  end
end