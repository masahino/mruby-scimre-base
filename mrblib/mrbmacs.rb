module Mrbmacs
  class Application
    include Scintilla

    attr_accessor :frame, :mark_pos
    attr_accessor :current_buffer, :buffer_list, :prev_buffer
    attr_accessor :theme
    attr_accessor :file_encodings, :system_encodings
    def initialize(init_filename, opts = nil)
      @frame = Mrbmacs::Frame.new()
      @keymap = ViewKeyMap.new(@frame.view_win)
      @command_list = @keymap.command_list
      @echo_keymap = EchoWinKeyMap.new(@frame.echo_win)

      @theme = SolarizedDarkTheme.new
      @mark_pos = nil
      @buffer_list = []
      @current_buffer = nil
      @filename = nil

      @file_encodings = []
      @system_encodings = Mrbmacs::get_encoding_list()
      load_init_file(init_filename)
      set_default_style
    end

    def set_default_style
      @frame.view_win.sci_style_set_fore(Scintilla::STYLE_DEFAULT, @theme.foreground_color)
      @frame.view_win.sci_style_set_back(Scintilla::STYLE_DEFAULT, @theme.background_color)
      @frame.view_win.sci_style_clear_all
#      @frame.view_win.refresh
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

    def run(file = nil)
      if file != nil
        buffer = Mrbmacs::Buffer.new(file)
        @current_buffer = buffer
        Mrbmacs::load_file(self, file)
        @frame.view_win.sci_set_lexer_language(buffer.mode.name)
        if $DEBUG
          $stderr.puts "["+@frame.view_win.sci_get_lexer_language()+"]"
        end
        @frame.view_win.sci_style_set_fore(Scintilla::STYLE_DEFAULT,
                                           @theme.foreground_color)
        @frame.view_win.sci_style_set_back(Scintilla::STYLE_DEFAULT,
                                           @theme.background_color)
        @frame.view_win.sci_style_clear_all
        @current_buffer.mode.set_style(@frame.view_win, @theme)
        @frame.view_win.sci_set_sel_back(true, 0xff0000)
#        @frame.view_win.refresh
        @filename = file
      else
        buffer = Mrbmacs::Buffer.new(nil)
        @current_buffer = buffer
      end
      buffer.docpointer = @frame.view_win.sci_get_docpointer()
      @prev_buffer = buffer
      @buffer_list.push(buffer)
      @frame.modeline(self)

      editloop()
    end
  end
end
