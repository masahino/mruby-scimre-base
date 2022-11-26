# Mrbmacs
module Mrbmacs
  def self.dir_glob(input_text)
    file_list = []
    len = 0
    if input_text[-1] == File::SEPARATOR
      file_list = (Dir.entries(input_text) - ['.', '..']).sort
    else
      dir = File.dirname(input_text)
      fname = File.basename(input_text)
      Dir.foreach(dir) do |item|
        file_list.push(item) if item =~ /^#{fname}/
      end
      len = fname.length
    end
    [file_list, len]
  end

  # Command
  module Command
    def insert_file(file_path = nil)
      view_win = @frame.view_win
      file_path = read_file_name('insert file: ', @current_buffer.directory) if file_path.nil?
      return if file_path.nil?

      if File.exist?(file_path) == true && FileTest.file?(file_path) == true
        text = File.open(file_path).read
        view_win.sci_insert_text(view_win.sci_get_current_pos, text)
      else
        message('no match')
      end
    end

    def find_file(filename = nil)
      filename = read_file_name('find file: ', @current_buffer.directory) if filename.nil?
      return if filename.nil?

      if Mrbmacs.get_buffer_from_path(@buffer_list, filename) != nil
        switch_to_buffer(Mrbmacs.get_buffer_from_path(@buffer_list, filename).name)
      else
        @current_buffer.pos = @frame.view_win.sci_get_current_pos
        new_buffer = Buffer.new(filename)
        if @current_buffer.docpointer != nil
          @frame.view_win.sci_add_refdocument(@current_buffer.docpointer)
        end
        @frame.view_win.sci_set_docpointer(nil)
        new_buffer.docpointer = @frame.view_win.sci_get_docpointer
        add_new_buffer(new_buffer)
        @current_buffer = new_buffer
        add_buffer_to_frame(@current_buffer)
        open_file(filename)
        @frame.view_win.sci_set_lexer_language(@current_buffer.mode.lexer)
        @current_buffer.mode.set_style(@frame.view_win, @theme)
        @frame.set_buffer_name(@current_buffer.name)
        @frame.edit_win.buffer = @current_buffer
        @frame.modeline(self)
        if @config.use_builtin_syntax_check == true
          error = @current_buffer.mode.syntax_check(@frame.view_win)
          @frame.show_annotation(error[0], error[1], error[2]) if error.size > 0
        end
      end
      after_find_file(self, filename)
    end

    def save_buffer
      all_text = @frame.view_win.sci_get_text(@frame.view_win.sci_get_length + 1)
      if @current_buffer.encoding != 'utf-8'
        all_text = Iconv.conv(@current_buffer.encoding, 'utf-8', all_text)
      end
      #    $stderr.print all_text
      #      File.open(app.filename, "w") do |f|
      File.open(@current_buffer.filename, 'w') do |f|
        f.write all_text
      end
      @frame.view_win.sci_set_save_point

      if @config.use_builtin_syntax_check == true
        @frame.view_win.sci_annotation_clearall
        error = @current_buffer.mode.syntax_check(@frame.view_win)
        if error.size > 0
          @frame.show_annotation(error[0], error[1], error[2])
        end
      end
      after_save_buffer(self, @current_buffer.filename)
    end

    def write_file(filename = nil)
      if filename.nil?
        filename = read_save_file_name('write file: ', @current_buffer.directory, @current_buffer.basename)
      end
      return if filename.nil?

      @current_buffer.update_filename(filename)
      save_buffer
      @frame.view_win.sci_set_lexer_language(@current_buffer.mode.lexer)
      @current_buffer.mode.set_style(@frame.view_win, @theme)
      @frame.set_buffer_name(@current_buffer.name)
    end
  end

  # Application
  class Application
    include Command

    def read_dir_name(prompt, default_directory = nil)
      prefix_text = default_directory
      prefix_text += '/' if prefix_text[-1] != '/'
      dirname = @frame.echo_gets(prompt, prefix_text) do |input_text|
        dir_list = []
        len = 0
        if input_text[-1] == '/'
          dir_list = Dir.entries(input_text).select { |f| File.directory?(f) }
        else
          dir = File.dirname(input_text)
          fname = File.basename(input_text)
          qfname = Regexp.quote(fname)
          Dir.foreach(dir) do |item|
            dir_list.push(item) if File.directory?(item) && item =~ /^#{qfname}/
          end
          len = fname.length
        end
        [dir_list.sort.join(' '), len]
      end
      @frame.modeline_refresh(self)
      dirname
    end

    def read_file_name(prompt, directory, default_name = nil)
      prefix_text = directory + '/'
      if default_name != nil
        prefix_text += default_name
      end
      filename = @frame.echo_gets(prompt, prefix_text) do |input_text|
        file_list = []
        len = 0
        if input_text[-1] == '/'
          file_list = Dir.entries(input_text)
        else
          dir = File.dirname(input_text)
          fname = File.basename(input_text)
          qfname = Regexp.quote(fname)
          Dir.foreach(dir) do |item|
            file_list.push(item) if item =~ /^#{qfname}/
          end
          len = fname.length
        end
        [file_list.sort.join(' '), len]
      end
      @frame.modeline_refresh(self)
      filename
    end

    def read_save_file_name(prompt, directory, default_name = nil)
      read_file_name(prompt, directory, default_name)
    end

    def open_file(filename)
      view_win = @frame.view_win
      begin
        file_encoding = 'utf-8'
        text = File.open(filename).read
        @config.file_encodings.each do |from|
          tmp_text = ''
          begin
            tmp_text = Iconv.conv('utf-8', from, text)
          rescue StandardError
            next
          end
          file_encoding = from if tmp_text.size != text.size
          break
        end
        if file_encoding != 'utf-8'
          text = Iconv.conv('utf-8', file_encoding, text)
          @current_buffer.encoding = file_encoding
        end
        mod_mask = view_win.sci_get_mod_event_mask
        view_win.sci_set_mod_event_mask(0)
        view_win.sci_set_codepage(Scintilla::SC_CP_UTF8)
        view_win.sci_set_text(text)
        eolmode = view_win.sci_get_eolmode
        cr = text.scan(/\r/).length
        lf = text.scan(/\n/).length
        crlf = text.scan(/\r\n/).length
        if crlf > 0
          eolmode = Scintilla::SC_EOL_CRLF
        elsif lf > cr
          eolmode = Scintilla::SC_EOL_LF
        elsif cr > 0
          eolmode = Scintilla::SC_EOL_CR
        end
        view_win.sci_set_eolmode(eolmode)
        view_win.sci_set_savepoint
        view_win.sci_empty_undo_buffer
        view_win.sci_set_mod_event_mask(mod_mask)
        view_win.sci_set_change_history Scintilla::SC_CHANGE_HISTORY_ENABLED | Scintilla::SC_CHANGE_HISTORY_MARKERS
      rescue StandardError
        # new file
        message 'error load file'
      end
    end
  end
end
