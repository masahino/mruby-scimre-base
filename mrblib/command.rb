module Mrbmacs
  class Application
    def execute_extended_command
      # command_list = @command_list.values.select {|item| item.kind_of?(String)}
      command_list = ( Mrbmacs::Application.instance_methods - Object.instance_methods).map { |item| item.to_s }
      input_str = @frame.echo_gets('M-x ') do |input_text|
        command_candidate = command_list.select { |item| item =~ /^#{input_text}/ }
        [command_candidate.join(' '), input_text.length]
      end
      if input_str != nil
        args = input_str.split(/\s/)
        command = args.shift
        if args != []
          args = "\"#{args.join(' ')}\""
        else
          args = nil
        end
        begin
          eval("#{command.gsub('-', '_')}(#{args})")
        rescue
          @logger.error $!
          message "#{command} no found"
        end
      end
    end

    def method_missing(method, *args)
      if method.to_s[0..3].upcase == 'SCI_'
        @logger.debug "call: #{method}"
        @frame.view_win.send(method, *args)
      elsif @command_handler[method.to_sym] != nil
        @command_handler[method.to_sym].each do |m|
          m.call(*args)
        end
      elsif method.to_s[-5, 5] == '_mode'
        mode_name = method.to_s[0..-6]
        mode_class_name = mode_name.capitalize + 'Mode'
        if Mrbmacs.const_defined?(mode_class_name)
          @current_buffer.mode = Mrbmacs.const_get(mode_class_name).new
          @frame.view_win.sci_set_lexer_language(@current_buffer.mode.lexer)
          @current_buffer.mode.set_style(@frame.view_win, @theme)
        end
      end
    end

    def exec_shell_command(buffer_name, command)
      result_buffer = Mrbmacs.get_buffer_from_name(@buffer_list, buffer_name)
      if result_buffer.nil?
        result_buffer = Mrbmacs::Buffer.new(buffer_name)
        add_new_buffer(result_buffer)
        add_buffer_to_frame(result_buffer)
        set_buffer_mode(result_buffer)
        @frame.set_theme(@theme)
        @frame.set_buffer_name(buffer_name)
      end
      switch_to_buffer(buffer_name)
      @current_buffer.docpointer = @frame.view_win.sci_get_docpointer
      @frame.view_win.sci_clear_all
      if Object.const_defined? 'Open3'
        _o, e, s = Open3.capture3(command)
        @frame.view_win.sci_set_text(e)
        @frame.view_win.sci_goto_pos(@frame.view_win.sci_get_length)
        @frame.view_win.sci_insert_text(@frame.view_win.sci_get_length, "\n")
        if s == 0
          @frame.view_win.sci_insert_text(@frame.view_win.sci_get_length, "#{command} finished")
        else
          @frame.view_win.sci_insert_text(@frame.view_win.sci_get_length, "#{command} exited with abnormally with code #{s}")
        end
      else
        io = IO.popen(command + ' 2>&1')
        add_io_read_event(io) do |app, io_arg|
          ret = io_arg.read(256)
          if ret != nil
            if app.current_buffer.name == buffer_name
              app.frame.view_win.sci_insert_text(app.frame.view_win.sci_get_length, ret)
              app.frame.view_win.sci_goto_pos(app.frame.view_win.sci_get_length)
            end
          else
            app.frame.view_win.sci_insert_text(app.frame.view_win.sci_get_length, "\n#{command} finished")
            app.del_io_read_event(io_arg)
          end
        end
      end
    end
  end
end
