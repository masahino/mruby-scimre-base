module Mrbmacs
  class SciEvent
    attr_accessor :priority, :proc
    def initialize(priority, proc)
      @priority = priority
      @proc = proc
    end
  end

  class Application
    def call_sci_event(e)
      if @sci_handler[e['code']] != nil
        begin
          @sci_handler[e['code']].each do |s|
            s.proc.call(self, e)
          end
        rescue => e
          @logger.error e.to_s
          @logger.error e.backtrace
          @frame.echo_puts e.to_s
        end
      end
    end
  end
end