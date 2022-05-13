module Mrbmacs
  class Application
    def eval_last_exp()
      text, pos = @frame.view_win.sci_get_curline
      begin
        ret = eval(text[0..pos-1])
      rescue Exception => e
      end
      @frame.view_win.sci_newline
      @frame.view_win.sci_addtext(ret.to_s.length, ret.to_s)
      @frame.view_win.sci_newline
    end

    def eval_buffer
      all_text = @frame.view_win.sci_get_text(@frame.view_win.sci_get_length + 1)
      begin
        ret = eval(all_text)
      rescue
        $stderr.puts $!
      end
      $stderr.puts ret.to_s
    end
  end
end
