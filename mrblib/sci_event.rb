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

    def set_brace_highlight(scn)
      pos = @frame.view_win.sci_bracematch(get_current_pos, 0)
      if pos != -1
        @frame.view_win.sci_brace_highlight(pos, get_current_pos)
      else
        @frame.view_win.sci_brace_highlight(-1, -1)
      end
    end

    def display_selection_range(scn)
      if scn['updated'] & Scintilla::SC_UPDATE_SELECTION
        if @mark_pos != nil
#          @frame.view_win.sci_set_anchor(@mark_pos)
        end
      end
    end
  end
end
