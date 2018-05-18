module Mrbmacs
  class Application
    include Scintilla

    attr_accessor :frame, :mark_pos
    attr_accessor :current_buffer, :buffer_list, :prev_buffer
    attr_accessor :theme
    attr_accessor :file_encodings, :system_encodings
    def initialize(init_filename, opts = nil)
      @current_buffer = Buffer.new("*scratch*")
      @frame = Mrbmacs::Frame.new(@current_buffer)
      @current_buffer.docpointer = @frame.view_win.sci_get_docpointer
      @keymap = ViewKeyMap.new()
      @keymap.set_keymap(@frame.view_win)
      @command_list = @keymap.command_list
      @echo_keymap = EchoWinKeyMap.new()
      @keymap.set_keymap(@frame.echo_win)

      @theme = SolarizedDarkTheme.new
#      if @theme.respond_to?(:set_pallete)
#        @theme.set_pallete
#      end
      @mark_pos = nil
      @buffer_list = [@current_buffer]
      @filename = nil
      @target_start_pos = nil

      @file_encodings = []
      @system_encodings = Mrbmacs::get_encoding_list()

      @auto_completion = false
      set_default_style
      load_init_file(init_filename)
      @frame.modeline(self)
    end

    def set_default_style
      @frame.view_win.sci_style_set_fore(Scintilla::STYLE_DEFAULT, @theme.foreground_color)
      @frame.view_win.sci_style_set_back(Scintilla::STYLE_DEFAULT, @theme.background_color)
      @frame.view_win.sci_style_clear_all
      if @theme.font_color[:color_brace_highlight]
        @frame.view_win.sci_style_set_fore(Scintilla::STYLE_BRACELIGHT,
          @theme.font_color[:color_brace_highlight][0])
        @frame.view_win.sci_style_set_back(Scintilla::STYLE_BRACELIGHT,
          @theme.font_color[:color_brace_highlight][1])
      end
      if @theme.font_color[:color_annotation]
        @frame.view_win.sci_style_set_fore(254, @theme.font_color[:color_annotation][0])
        @frame.view_win.sci_style_set_back(254, @theme.font_color[:color_annotation][1])
        @frame.view_win.sci_annotation_set_visible(Scintilla::ANNOTATION_BOXED)
      end
#      @frame.view_win.refresh
    end

    def load_init_file(init_filename)
      begin
        File.open(init_filename, "r") do |f|
          init_str = f.read()
          eval(init_str)
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
          eval("#{command.gsub("-", "_")}()")
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
        find_file(file)
      end
      editloop()
    end
  end
end
