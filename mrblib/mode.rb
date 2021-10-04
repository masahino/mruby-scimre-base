module Mrbmacs
  $mode_list = {
    # ruby-mode
    '.rb' => 'ruby',
    '.rake' => 'ruby',
    'Rakefile' => 'ruby',
    '.mrbmacsrc' => 'ruby',
    '.c' => 'cpp',
    '.h' => 'cpp',
    '.cpp' => 'cpp',
    '.cxx' => 'cpp',
    '.css' => 'css',
    '.diff' => 'diff',
    '.java' => 'java',
    '.js' => 'javascript',
    '.json' => 'json',
    '.md' => 'markdown',
    '.txt' => 'fundamental',
    '.hs' => 'haskell',
    '.html' => 'html',
    '.htm' => 'html',
    '.lisp' => 'lisp',
    '.erb' => 'html',
    '.sh' => 'bash',
    '.go' => 'go',
    '.pl' => 'perl',
    '.py' => 'python',
    '.r' => 'r',
    '.rs' => 'rust',
    '.tex' => 'latex',
    '.xml' => 'xml',
    '.plist' => 'xml',
    '.yml' => 'yaml',
    '.yaml' => 'yaml',
    'Makefile' => 'make',
    'makefile' => 'make',
    '' => 'fundamental',
    '*scratch*' => 'irb',
    '*compilation*' => 'compilation',
    '*Messages*' => 'fundamental'
  }

  class Mode
    include Singleton
    attr_accessor :name, :lexer, :indent, :use_tab, :keymap

    #    def name
    #      @name
    #    end

    def self.get_mode_by_suffix(suffix)
      if $mode_list.key?(suffix)
        $mode_list[suffix]
      else
        'fundamental'
      end
    end

    def self.get_mode_by_filename(filename)
      key = File.extname(filename)
      if key == ''
        key = File.basename(filename)
      end
      if $mode_list.key?(key)
        $mode_list[key]
      else
        'fundamental'
      end
    end

    def self.get_mode_by_name(mode_name)
      if Mrbmacs.const_defined?(mode_name.capitalize + 'Mode')
        Mrbmacs.const_get(mode_name.capitalize + 'Mode').instance
      else
        nil
      end
    end

    def self.set_mode_by_filename(filename)
      cur_mode = get_mode_by_filename(filename)
      Mrbmacs.const_get(cur_mode.capitalize + 'Mode').instance
    end

    def initialize
      @name = 'default'
      @keyword_list = ''
      @style = [:color_foreground]
      @indent = 2
      @use_tab = false
      @tab_indent = 0
      @lexer = @name
      @keymap = {}
    end

    def set_lexer(view_win)
      if @lexer != nil
        view_win.sci_set_lexer_language(@name)
      end
    end

    def set_style(view_win, theme)
      for i in 0..@style.length - 1
        color = theme.font_color[@style[i]]
        if color[0] # foreground
          view_win.sci_style_set_fore(i, color[0])
        end
        if color[1] # background
          view_win.sci_style_set_back(i, color[1])
        end
        if color[2] # italic
          view_win.sci_style_set_italic(i, color[2])
        end
        if color[3] # bold
          view_win.sci_style_set_bold(i, color[3])
        end
      end

      #     # bracelight
      #      view_win.sci_style_set_fore(34, theme.background_color)
      #      view_win.sci_style_set_back(34, theme.foreground_color)

      view_win.sci_set_keywords(0, @keyword_list)
      view_win.sci_set_property('fold', '1')
      view_win.sci_set_tab_width(@indent)
      view_win.sci_set_use_tabs(@use_tabs)
      view_win.sci_set_tab_indents(@tab_indent)
      view_win.sci_set_back_space_un_indents(true)
      view_win.sci_set_indent(@indent)
      view_win.sci_set_wrap_mode(Scintilla::SC_WRAP_CHAR)
    end

    def config
    end

    def is_end_of_block(line)
      false
    end

    def get_indent_level(view_win)
      line = view_win.sci_line_from_position(view_win.sci_get_current_pos)
      level = view_win.sci_get_fold_level(line) & Scintilla::SC_FOLDLEVELNUMBERMASK - Scintilla::SC_FOLDLEVELBASE
      cur_line = view_win.sci_get_curline[0]
      if level > 0 and is_end_of_block(cur_line) == true
        level -= 1
      end
      return level
    end

    def syntax_check(_view_win)
      []
    end

    def get_candidates(_input)
      @keyword_list
    end

    def get_completion_list(view_win)
      pos = view_win.sci_get_current_pos
      col = view_win.sci_get_column(pos)
      if col > 0
        line = view_win.sci_line_from_position(pos)
        line_text = view_win.sci_get_line(line).chomp[0..col]
        input = line_text.split(' ').pop
        if input != nil and input.length > 0
          candidates = get_candidates(input)
          [input.length, candidates]
        else
          [0, []]
        end
      else
        [0, []]
      end
    end

    def add_keybind(key_str, command)
      @keymap[key_str] = command
    end

    def on_style_needed(app, notify)
      #      $stderr.puts "on_style_needed"
    end
  end

  class FundamentalMode < Mode
    def initialize
      super.initialize
      @name = 'fundamental'
      @lexer = 'indent'
      @style = [:color_foreground]
    end
  end
end
