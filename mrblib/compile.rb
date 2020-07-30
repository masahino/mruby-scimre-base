module Mrbmacs
  class Application
    def compile()
      #      IO.popen("make", :err => [:child, :out]) do |pipe|
      buffer_name = "*compilation*"
      result_buffer = Mrbmacs::get_buffer_from_name(@buffer_list, buffer_name)
      if result_buffer == nil
        result_buffer = Mrbmacs::Buffer.new(buffer_name, @buffer_list)
        @buffer_list.push(result_buffer)
      end
      switch_to_buffer(buffer_name)
      @current_buffer.docpointer = @frame.view_win.sci_get_docpointer()
      o, e, s = Open3.capture3("make")
      @frame.view_win.sci_set_text(e)
      @frame.view_win.sci_goto_pos(@frame.view_win.sci_get_length)
      @frame.view_win.sci_insert_text(@frame.view_win.sci_get_length, "\n")
      if s == 0
        @frame.view_win.sci_insert_text(@frame.view_win.sci_get_length, "Compilation finished")
      else
        @frame.view_win.sci_insert_text(@frame.view_win.sci_get_length, "Compilation exited with abnormally with code #{s}")
      end
    end
  end
end
