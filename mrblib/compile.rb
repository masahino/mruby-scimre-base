module Mrbmacs
  class Application
    def compile_command(command)
      #      IO.popen("make", :err => [:child, :out]) do |pipe|
      buffer_name = "*compilation*"
      result_buffer = Mrbmacs::get_buffer_from_name(@buffer_list, buffer_name)
      if result_buffer == nil
        result_buffer = Mrbmacs::Buffer.new(buffer_name)
        add_new_buffer(result_buffer)
        add_buffer_to_frame(result_buffer)
        set_buffer_mode(result_buffer)
        @frame.set_theme(@theme)
        @frame.set_buffer_name(buffer_name)
      end
      switch_to_buffer(buffer_name)
      @current_buffer.docpointer = @frame.view_win.sci_get_docpointer()
      if Object.const_defined? 'Open3'
        o, e, s = Open3.capture3(command)
        @frame.view_win.sci_set_text(e)
        @frame.view_win.sci_goto_pos(@frame.view_win.sci_get_length)
        @frame.view_win.sci_insert_text(@frame.view_win.sci_get_length, "\n")
        if s == 0
          @frame.view_win.sci_insert_text(@frame.view_win.sci_get_length, "Compilation finished")
        else
          @frame.view_win.sci_insert_text(@frame.view_win.sci_get_length, "Compilation exited with abnormally with code #{s}")
        end
      else
        io = IO.popen(command + " 2>&1")
        add_io_read_event(io) do |app, io|
          ret = io.read(256)
          if ret != nil
            if app.current_buffer.name == "*compilation*"
              app.frame.view_win.sci_insert_text(app.frame.view_win.sci_get_length, ret)
              app.frame.view_win.sci_goto_pos(app.frame.view_win.sci_get_length)
            end
          else
            $stderr.puts "EOF"
            app.del_io_read_event(io)
            io.close
          end
        end
      end
    end
    def compile
      default_command = @project.build_command
      if @project.last_build_command != nil
        default_command = @project.last_build_command
      end
      command = @frame.echo_gets("Compile command: ", default_command)
      if command != nil
        @project.last_build_command = command
        compile_command(command)
      end
    end
    def recompile
      if @project.last_build_command == nil
        command = @frame.echo_gets("Compile command: ", @project.build_command)
        if command != nil
          @project.last_build_command = command
        end
      end
      if @project.last_build_command != nil
        compile_command(@project.last_build_command)
      end
    end
  end
end
