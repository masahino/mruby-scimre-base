module Mrbmacs
  # builtin completion
  class Application
    def builtin_completion(_scn)
      len, candidates = @current_buffer.mode.get_completion_list(@frame.view_win)
      if len > 0 && candidates.length > 0
        @frame.view_win.sci_autoc_show(len, candidates)
      end
    end
  end
end
