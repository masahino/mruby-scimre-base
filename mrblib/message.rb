module Mrbmacs
  class Application
    def message(text)
      @logger.info text
      @frame.echo_puts text
    end
  end
end
