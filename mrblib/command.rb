module Mrbmacs
  class Application
  def execute_extended_command()
    echo_win = @frame.echo_win
    command = @frame.echo_gets("M-x ")
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
