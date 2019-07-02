module Mrbmacs
  class Application
    def builtin_completion(scn)
      len, candidates = @current_buffer.mode.get_completion_list(@frame.view_win)
      if len > 0 and candidates.length > 0
        @frame.view_win.sci_autoc_show(len, candidates)
      end
    end
  end
end