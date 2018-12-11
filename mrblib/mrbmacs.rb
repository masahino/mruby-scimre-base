module Mrbmacs
  class Application
    include Scintilla

    attr_accessor :frame, :mark_pos
    attr_accessor :current_buffer, :buffer_list, :prev_buffer
    attr_accessor :theme
    attr_accessor :file_encodings, :system_encodings
    attr_accessor :lsp
    def parse_args(argv)
      op = OptionParser.new
      opts = {
        no_init_file: false,
        load: '',
      }
      op.on('-q', '--[no-]init-file', "do not load ~/.mrbmacs") do |v|
        opts[:no_init_file] = v
      end
      op.on('-l', '--load FILE', "load ruby file") do |v|
        opts[:load] = v
      end
     op.on("-h", "--help", "Prints this help") do
        puts op.to_s
        exit
      end
      op.banner = "Usage: mrbmacs-curses OPTION-OR-FILENAME]..."
      begin 
        args = op.parse(argv)
      rescue => e
        puts e.message
        puts op.to_s
        exit
      end
      [opts, args]
    end

    def initialize(argv = [])
      opts, argv = parse_args(argv)
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
      @lsp = {}
      set_default_style()
      register_extensions()
      if opts[:no_init_file] == false
        init_filename = ENV['HOME'] + "/.mrbmacsrc"
        load_file(init_filename)
      end
      if argv.size > 0
        find_file(argv[0])
      end
      if opts[:load] != ''
        load_file(opts[:load])
      end
      @frame.modeline(self)
    end

    def register_extensions
      Extension.singleton_methods(false).each do |m|
        if m.to_s =~ /^register_/
          Extension.send(m, self)
        end
      end
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

    def load_file(filename)
      begin
        File.open(filename, "r") do |f|
          str = f.read()
          eval(str)
        end
      rescue
        $stderr.puts  $!
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
