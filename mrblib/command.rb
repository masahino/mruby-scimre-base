module Mrbmacs
  class Application
    def execute_extended_command()
      echo_win = @frame.echo_win
#      command_list = @command_list.values.select {|item| item.kind_of?(String)}
      command_list = (Mrbmacs::Application.instance_methods - Object.instance_methods).map {|item| item.to_s}
      input_str = @frame.echo_gets("M-x ") do |input_text|
        command_candidate = command_list.select {|item| item =~ /^#{input_text}/}
        [command_candidate.join(" "), input_text.length]
      end
      if input_str != ""
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
          $stderr.puts $!
        end
      end
    end

    def method_missing(method, *args)
      if method.to_s[0..3].upcase == "SCI_"
        @logger.debug "call: #{method}"
        @frame.view_win.send(method, *args)
      end
      if @command_handler[method.to_sym] != nil
        @command_handler[method.to_sym].each do |m|
          m.call(*args)
        end
      end
    end
  end
end
