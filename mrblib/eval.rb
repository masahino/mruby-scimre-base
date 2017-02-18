module Mrbmacs
  class Application
    def eval_last_exp()
      text, pos = @frame.view_win.sci_get_curline
      begin
        ret = eval(text[0..pos-1])
      rescue
#        $stderr.puts $!
      end
      @frame.view_win.sci_newline
      @frame.view_win.sci_addtext(ret.to_s.length, ret.to_s)
      @frame.view_win.sci_newline
    end
  end
end
