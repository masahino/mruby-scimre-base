module Mrbmacs
  # command
  module Command
    def execute_extended_command
      command_list = Mrbmacs::Command.instance_methods.map { |item| item.to_s }.sort
      input_str = @frame.echo_gets('M-x ') do |input_text|
        command_candidate = command_list.select { |item| item =~ /^#{input_text}/ }
        [command_candidate.join(@frame.echo_win.sci_autoc_get_separator.chr), input_text.length]
      end
      return if input_str.nil?

      args = input_str.split(/\s/)
      command = args.shift
      args = args.join(' ')
      args = nil if args == ''
      begin
        instance_eval("#{command.gsub('-', '_')}(#{args})", __FILE__, __LINE__)
      rescue StandardError => e
        @logger.error e.to_s
        message "#{command} error"
      end
    end
  end

  class Application
    include Command

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

    def setup_result_buffer(buffer_name)
      tmp_win = @frame.edit_win_from_buffer(buffer_name)
      unless tmp_win.nil?
        @frame.switch_window(tmp_win)
        @current_buffer = @frame.edit_win.buffer
        return
      end
      split_window_vertically if @frame.edit_win_list.size == 1
      other_window
      # @frame.refresh_all

      result_buffer = Mrbmacs.get_buffer_from_name(@buffer_list, buffer_name)
      if result_buffer.nil?
        result_buffer = Mrbmacs::Buffer.new(buffer_name)
        if @current_buffer.docpointer != nil
          @frame.view_win.sci_add_refdocument(@current_buffer.docpointer)
        end
        @frame.view_win.sci_set_docpointer(nil)
        result_buffer.docpointer = @frame.view_win.sci_get_docpointer
        add_new_buffer(result_buffer)
        @current_buffer = result_buffer
        add_buffer_to_frame(result_buffer)
        set_buffer_mode(result_buffer)
        # @frame.set_theme(@theme)
        @current_buffer.mode.set_style(@frame.view_win, @theme)
        @frame.set_buffer_name(buffer_name)
        @frame.edit_win.buffer = @current_buffer
      else
        switch_to_buffer(buffer_name)
      end
    end

    def exec_shell_command(buffer_name, command)
      setup_result_buffer(buffer_name)
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
          ret = io_arg.read(256) unless io_arg.closed?
          result_win = app.frame.edit_win_from_buffer(buffer_name)
          if !ret.nil?
            if app.current_buffer.name == buffer_name
              result_win.sci.sci_insert_text(result_win.sci.sci_get_length, ret)
              result_win.sci.sci_goto_pos(result_win.sci.sci_get_length)
            end
          else
            result_win.sci.sci_insert_text(result_win.sci.sci_get_length, "\n#{command} finished")
            result_win.sci.sci_goto_pos(result_win.sci.sci_get_length)
            app.del_io_read_event(io_arg)
          end
        end
      end
    end
  end
end
