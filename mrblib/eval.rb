module Mrbmacs
  class << self
    def eval_last_exp(app)
      text, pos = app.frame.view_win.sci_get_curline
      begin
        ret = instance_eval(text[0..pos-1])
      rescue
#        $stderr.puts $!
      end
      app.frame.view_win.sci_newline
      app.frame.view_win.sci_addtext(ret.to_s.length, ret.to_s)
      app.frame.view_win.sci_newline
    end
  end
end
