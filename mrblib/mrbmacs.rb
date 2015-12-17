module Mrbmacs
  class Application
    include Scintilla

    attr_accessor :frame, :mark_pos
    attr_accessor :current_buffer, :buffer_list, :prev_buffer
    attr_accessor :mode
    attr_accessor :theme
    attr_accessor :file_encodings
    def initialize(init_filename, opts = nil)
      @frame = Mrbmacs::Frame.new()
      @keymap = ViewKeyMap.new(@frame.view_win)
      @command_list = @keymap.command_list
      @echo_keymap = EchoWinKeyMap.new(@frame.echo_win)

      @mode = Mode.new
      @theme = SolarizedDarkTheme.new
      @mark_pos = nil
      @buffer_list = []
      @current_buffer = nil
      @filename = nil

      @file_encodings = []
      load_init_file(init_filename)
    end

    def load_init_file(init_filename)
      begin
        File.open(init_filename, "r") do |f|
          init_str = f.read()
          instance_eval(init_str)
        end
      rescue
        $stderr.puts $!
      end
    end

    def extend(command)
      if command.class.to_s == "Fixnum"
        @frame.view_win.send_message(command)
      else
        begin
          instance_eval("Mrbmacs::#{command.gsub("-", "_")}(self)")
        rescue
          $stderr.puts $!
        end
      end
    end

    def doin()
      key, command = doscan("")
      if $DEBUG
        $stderr.puts command
      end
      if command == nil
        @frame.send_key(key)
      else
        extend(command)
      end
    end
  end
end
