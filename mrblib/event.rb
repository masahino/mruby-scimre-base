module Mrbmacs
  # Application
  class Application
    def add_io_read_event(io, &proc)
      @readings.push io
      @io_handler[io] = proc
    end

    def del_io_read_event(io)
      @readings.delete io
      @io_handler.delete(io)
      io.close
    end

    def add_sci_event(event_id, priority = nil, &proc)
      if @sci_handler[event_id].nil?
        priority = 100 if priority.nil?
        @sci_handler[event_id] = [SciEvent.new(priority, proc)]
      else
        if priority.nil?
          if @sci_handler[event_id].last.priority < 100
            priority = 100
          else
            priority = @sci_handler[event_id].last.priority + 1
          end
        end
        @sci_handler[event_id].push SciEvent.new(priority, proc)
        @sci_handler[event_id].sort! { |a, b| a.priority <=> b.priority }
      end
    end

    def add_command_event(method, &proc)
      @command_handler[method] = [] if @command_handler[method].nil?
      @command_handler[method].push proc
    end
  end
end