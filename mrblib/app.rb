module Mrbmacs
  # Application
  class Application
    include Scintilla

    attr_accessor :frame, :mark_pos, :current_buffer, :buffer_list, :theme,
                  :sci_handler, :ext, :config, :modeline, :project, :io_handler

    def parse_args(argv)
      op = OptionParser.new
      opts = {
        # version = [1, 1],
        no_init_file: false,
        load: ''
      }
      op.on('-q', '--[no-]init-file', 'do not load ~/.mrbmacs') do |v|
        opts[:no_init_file] = v
      end
      op.on('-l', '--load FILE', 'load ruby file') do |v|
        opts[:load] = v
      end
      op.on('-d', '--debug', 'set debugging flags (set $DEBUG to true)') do |_v|
        $DEBUG = true
      end
      op.on('-h', '--help', 'Prints this help') do
        puts op.to_s
        exit
      end
      op.on('-v', '--veresion', 'show version') do
        puts Version
        exit
      end
      op.banner = "Usage: #{$0} [OPTION-OR-FILENAME]..."
      begin
        args = op.parse(argv)
      rescue StandardError => e
        puts e.message
        puts op.to_s
        exit
      end
      [opts, args]
    end

    def load_init_file
      homedir = Mrbmacs.homedir
      init_filename = "#{homedir}/.mrbmacsrc"
      @logger.debug 'load initfile'
      load_file(init_filename)
    end

    def init_logfile
      tmpdir = ENV['TMPDIR'] || ENV['TMP'] || ENV['TEMP'] || ENV['USERPROFILE'] || '/tmp'
      @logfile = "#{tmpdir}/mrbmacs-#{$$}.log"
      severity = $DEBUG ? Logger::Severity::DEBUG : Logger::Severity::INFO
      logger = Logger.new(@logfile, level: severity)
      logger.info 'Logging start'
      logger.info @logfile
      logger
    end

    def initialize(argv = [])
      opts, argv = parse_args(argv)
      @io_handler = {}
      @readings = []
      @sci_handler = {}
      @ext = Extension.new
      @config = Config.new
      @command_handler = {}
      @mark_pos = nil
      @target_start_pos = nil
      @last_search_text = ''
      @theme = nil
      @modeline = Modeline.new
      @recent_keys = []

      @logger = init_logfile

      @current_buffer = Buffer.new('*scratch*')
      @buffer_list = [@current_buffer]
      @frame = Mrbmacs::Frame.new(@current_buffer)
      @frame.set_buffer_name(@current_buffer.name)
      @current_buffer.docpointer = @frame.view_win.sci_get_docpointer
      init_keymap

      @themes = Theme.create_theme_list
      @project = Project.new(@current_buffer.directory)

      load_init_file if opts[:no_init_file] == false

      @theme = @config.theme.new
      @frame.apply_theme(@theme)
      @current_buffer.mode.set_style(@frame.view_win, @theme)

      register_extensions
      init_default_event
      create_messages_buffer(@logfile)
      find_file(argv[0]) if argv.size > 0
      load_file(opts[:load]) if opts[:load] != ''

      @frame.modeline(self)
    end

    def load_file(filename)
      File.open(File.expand_path(filename), 'r') do |f|
        str = f.read
        instance_eval(str)
      end
    rescue StandardError => e
      @logger.error e
    end

    def add_recent_key(key)
      @recent_keys.push key
      @recent_keys.shift if @recent_keys.length > 100
    end

    def extend(command)
      if command.is_a?(Integer)
        @frame.view_win.send_message(command)
      else
        begin
          instance_eval("#{command.gsub('-', '_')}()", __FILE__, __LINE__)
        rescue StandardError => e
          @logger.error e.to_s
          @frame.echo_puts e.to_s
        end
      end
    end

    def doin
      key, command = doscan('')
      return if key.nil?

      @logger.debug command
      if command.nil?
        @frame.send_key(key)
      else
        extend(command)
      end
    end

    def run(file = nil)
      @logger.debug 'run'
      find_file(file) unless file.nil?
      editloop
    end
  end
end
