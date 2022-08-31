module Mrbmacs
  class Application
    def grep(command = nil)
      command = @frame.echo_gets('Run Grep: ', 'grep -n ') if command.nil?
      return if command.nil?

      buffer_name = '*grep*'
      result_buffer = Mrbmacs.get_buffer_from_name(@buffer_list, buffer_name)
      if result_buffer.nil?
        result_buffer = Mrbmacs::Buffer.new(buffer_name)
        add_new_buffer(result_buffer)
        add_buffer_to_frame(result_buffer)
        set_buffer_mode(result_buffer)
        # @frame.set_theme(@theme)
        @frame.set_buffer_name(buffer_name)
      end
      result_buffer.mode.pattern = GrepMode.extract_pattern(command)
      exec_shell_command(buffer_name, command)
    end
  end
end
