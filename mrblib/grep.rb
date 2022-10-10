module Mrbmacs
  class Application
    def grep(command = nil)
      command = @frame.echo_gets("Run Grep[#{Dir.getwd}]: ", 'grep -n ') if command.nil?
      return if command.nil?

      buffer_name = '*grep*'
      setup_result_buffer(buffer_name)
      result_buffer = Mrbmacs.get_buffer_from_name(@buffer_list, buffer_name)
      result_buffer.mode.pattern = GrepMode.extract_pattern(command)
      exec_shell_command(buffer_name, command)
    end
  end
end
