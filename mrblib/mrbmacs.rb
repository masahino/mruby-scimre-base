module Mrbmacs
  class Application
    include Scintilla

    attr_accessor :frame, :mark_pos
    attr_accessor :current_buffer, :buffer_list
    attr_accessor :theme
    attr_accessor :file_encodings, :system_encodings
    attr_accessor :sci_handler, :ext
    attr_accessor :command_list
    attr_accessor :use_builtin_completion, :use_builtin_indent
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
      @use_builtin_completion = false
      @use_builtin_indent = false
      @last_search_text = ""
      @theme = nil
      @themes = Theme::create_theme_list

      tmpdir = ENV['TMPDIR'] || ENV['TMP'] || ENV['TEMP'] || ENV['USERPROFILE'] || "/tmp"
      logfile = tmpdir + "/mrbmacs-" + $$.to_s + ".log"
      @logger = Logger.new(logfile)
      @logger.info "Logging start"
      @logger.info logfile
      @current_buffer = Buffer.new("*scratch*")
      @buffer_list = [@current_buffer]
      @frame = Mrbmacs::Frame.new(@current_buffer)
      @frame.set_buffer_name(@current_buffer.name)
      @current_buffer.docpointer = @frame.view_win.sci_get_docpointer
      @keymap = ViewKeyMap.new()
      @keymap.set_keymap(@frame.view_win)
      @command_list = @keymap.command_list
      @echo_keymap = EchoWinKeyMap.new()
      @echo_keymap.set_keymap(@frame.echo_win)

      @system_encodings = Mrbmacs::get_encoding_list()

      if opts[:no_init_file] == false
        homedir = if ENV['HOME'] != nil
          ENV['HOME']
        elsif ENV['HOMEDRIVE'] != nil
          ENV['HOMEDRIVE']+ENV['HOMEPATH']
        else 
          ""
        end
        init_filename = homedir + "/.mrbmacsrc"
        load_file(init_filename)
      end
      if @theme == nil
        @theme = SolarizedDarkTheme.new
      end
      if @theme.respond_to?(:set_pallete)
       @theme.set_pallete
      end
      set_default_style()
      @current_buffer.mode.set_style(@frame.view_win, @theme)

      register_extensions()
      if @use_builtin_completion == true
        add_sci_event(Scintilla::SCN_CHARADDED) do |app, scn|
          builtin_completion(scn)
        end
      end

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
      @frame.set_buffer_name(@current_buffer.name)
      @current_buffer.directory = Dir.getwd
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
      @frame.set_theme(@theme)
    end

    def load_file(filename)
      begin
        File.open(File.expand_path(filename), "r") do |f|
          str = f.read()
          eval(str)
        end
      rescue => err
        @logger.error err
      end
    end

    def extend(command)
      if command.class.to_s == "Fixnum"
        @frame.view_win.send_message(command)
      else
        begin
          eval("#{command.gsub("-", "_")}()")
        rescue => err
          @logger.error err.to_s
          @frame.echo_puts err.to_s
        end
      end
    end

    def doin()
      key, command = doscan("")
      if key != nil
        @logger.debug command
        if command == nil
          @frame.send_key(key)
        else
          extend(command)
        end
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
