module Mrbmacs
  class Application
    def execute_extended_command()
      echo_win = @frame.echo_win
      command_list = @command_list.values.select {|item| item.kind_of?(String)}
      command = @frame.echo_gets("M-x ") do |input_text|
        command_candidate = command_list.select {|item| item =~ /^#{input_text}/}
        [command_candidate.join(" "), input_text.length]
      end
      if command != ""
        begin
          instance_eval("#{command.gsub("-", "_")}()")
        rescue
          $stderr.puts $!
        end
      end
    end
  end
end
