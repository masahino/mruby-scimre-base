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
    attr_accessor :config
    attr_accessor :modeline
    attr_accessor :project
    attr_accessor :io_handler

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
      op.banner = "Usage: #{$0} [OPTION-OR-FILENAME]..."
      begin 
        args = op.parse(argv)
      rescue => e
        puts e.message
        puts op.to_s
        exit
      end
      [opts, args]
    end

    def load_init_file()
      homedir = if ENV['HOME'] != nil
        ENV['HOME']
      elsif ENV['HOMEDRIVE'] != nil
        ENV['HOMEDRIVE']+ENV['HOMEPATH']
      else
        ""
      end
      init_filename = homedir + "/.mrbmacsrc"
      @logger.debug "load initfile"
      load_file(init_filename)
    end

    def initialize(argv = [])
      opts, argv = parse_args(argv)
      @io_handler = {}
      @readings = []
      @sci_handler = {}
      # TODO: data of extension
      @ext = Extension.new
      @config = Config.new
      @command_handler = {}
      @mark_pos = nil
      @filename = nil
      @target_start_pos = nil
      @file_encodings = []
      @last_search_text = ""
      @theme = nil
      @modeline = Modeline.new

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
      @themes = Theme::create_theme_list
      @project = Project.new(@current_buffer.directory)

      if opts[:no_init_file] == false
        load_init_file
      end

      @theme = @config.theme.new

#      if @theme.respond_to?(:set_pallete)
#       @theme.set_pallete
#      end
      set_default_style()
      @current_buffer.mode.set_style(@frame.view_win, @theme)

      register_extensions()
      if @config.use_builtin_completion == true
        add_sci_event(Scintilla::SCN_CHARADDED) do |app, scn|
          builtin_completion(scn)
        end
      end
      add_sci_event(Scintilla::SCN_UPDATEUI) do |app, scn|
        set_brace_highlight(scn)
      end
      add_sci_event(Scintilla::SCN_UPDATEUI) do |app, scn|
        display_selection_range(scn)
      end
      add_sci_event(Scintilla::SCN_STYLENEEDED) do |app, scn|
        @current_buffer.mode.on_style_needed(app, scn)
      end
      create_messages_buffer(logfile)

      if argv.size > 0
        find_file(argv[0])
      end
      if opts[:load] != ''
        load_file(opts[:load])
      end
      @frame.modeline(self)
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
      if command.is_a?(Integer)
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
      @logger.debug "run"
      if file != nil
        find_file(file)
      end
      editloop()
    end
  end
end
