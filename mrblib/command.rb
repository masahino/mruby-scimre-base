module Mrbmacs
  class Application
    def execute_extended_command()
#      command_list = @command_list.values.select {|item| item.kind_of?(String)}
      command_list = (Mrbmacs::Application.instance_methods - Object.instance_methods).map {|item| item.to_s}
      input_str = @frame.echo_gets("M-x ") do |input_text|
        command_candidate = command_list.select {|item| item =~ /^#{input_text}/}
        [command_candidate.join(" "), input_text.length]
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
          @frame.message $!
        end
      end
    end

    def method_missing(method, *args)
      if method.to_s[0..3].upcase == "SCI_"
        @logger.debug "call: #{method}"
        @frame.view_win.send(method, *args)
      elsif @command_handler[method.to_sym] != nil
        @command_handler[method.to_sym].each do |m|
          m.call(*args)
        end
      elsif method.to_s[-5, 5] == "_mode"
        mode_name = method.to_s[0..-6]
        mode_class_name = mode_name.capitalize+"Mode"
        if Mrbmacs.const_defined?(mode_class_name)
          @current_buffer.mode = Mrbmacs.const_get(mode_class_name).new
          @frame.view_win.sci_set_lexer_language(@current_buffer.mode.lexer)
          @current_buffer.mode.set_style(@frame.view_win, @theme)
        end
      end
    end
  end
end
