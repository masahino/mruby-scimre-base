module Mrbmacs
  class Application
    include Scintilla

    attr_accessor :frame, :mark_pos
    attr_accessor :current_buffer, :buffer_list
    attr_accessor :theme
    attr_accessor :file_encodings, :system_encodings
    attr_accessor :sci_handler, :ext
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
      op.on('-d', '--debug', "set debugging flags (set $DEBUG to true)") do |v|
        $DEBUG = true
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
      @io_handler = {}
      @readings = []
      @sci_handler = {}
      @ext = Extension.new
      @command_handler = {}
      @mark_pos = nil
      @filename = nil
      @target_start_pos = nil
      @file_encodings = []
      @auto_completion = false

      logfile = Dir.tmpdir + "/mrbmacs-" + $$.to_s + ".log"
      @logger = Logger.new(logfile)
      @logger.info "Logging start"
      @current_buffer = Buffer.new("*scratch*")
      @buffer_list = [@current_buffer]
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
      @system_encodings = Mrbmacs::get_encoding_list()

      if opts[:no_init_file] == false
        init_filename = ENV['HOME'] + "/.mrbmacsrc"
        load_file(init_filename)
      end
      set_default_style()
      register_extensions()

      create_message_buffer(logfile)

      if argv.size > 0
        find_file(argv[0])
      end
      if opts[:load] != ''
        load_file(opts[:load])
      end
      @frame.modeline(self)
    end

    def create_message_buffer(logfile)
      find_file(logfile)
      @current_buffer.name = "*Messages*"
      @frame.view_win.sci_set_readonly(1)
      @frame.view_win.sci_document_end
      switch_to_buffer "*scratch*"
    end

    def add_io_read_event(io, &proc)
      @readings.push io
      @io_handler[io] = proc
    end

    def add_sci_event(event_id, &proc)
      @sci_handler[event_id] = proc
    end

    def add_command_event(method, &proc)
      if @command_handler[method] == nil
        @command_handler[method] = []
      end
      @command_handler[method].push proc
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
      @logger.debug command
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
