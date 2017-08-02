module Mrbmacs
  class Application
    def load_file(filename)
      view_win = @frame.view_win
      file_encodings = @file_encodings
      current_buffer = @current_buffer
      begin
        file_encoding = "utf-8"
        text = File.open(filename).read
        file_encodings.each do |from|
          tmp_text = ""
          begin
            tmp_text = Iconv.conv("utf-8", from, text)
          rescue
            next
          end
          if tmp_text.size != text.size
            file_encoding = from
          end
          break
        end
        if file_encoding != "utf-8"
          text = Iconv.conv("utf-8", file_encoding, text)
          current_buffer.encoding = file_encoding
        end
        view_win.sci_set_codepage(Scintilla::SC_CP_UTF8)
        view_win.sci_set_text(text)
        view_win.sci_set_savepoint
      rescue
        # new file
        message "error load file"
      end
    end

    def save_buffer()
      all_text = @frame.view_win.sci_get_text(@frame.view_win.sci_get_length+1)
      if @current_buffer.encoding != "utf-8"
        all_text = Iconv.conv(@current_buffer.encoding, "utf-8", all_text)
      end
      #    $stderr.print all_text
      #      File.open(app.filename, "w") do |f|
      File.open(@current_buffer.filename, "w") do |f|
        f.write all_text
      end
      @frame.view_win.sci_set_save_point

      @frame.view_win.sci_annotation_clearall
      error = @current_buffer.mode.syntax_check(@frame.view_win)
      if error.size > 0
        @frame.show_annotation(error[0], error[1], error[2])
      end
    end

    def write_file(filename = nil)
      view_win = @frame.view_win
      
      if filename == nil
        dir = @current_buffer.directory
        prefix_text = dir + "/"
        
        filename = @frame.echo_gets("Write file: ", prefix_text) do |input_text|
          file_list = Dir.glob(input_text + "*")
          len = if input_text[-1] == "/"
                  0
                else
                  input_text.length - File.dirname(input_text).length - 1
                end
          [file_list.map{|f| File.basename(f)}.join(" "), len]
        end
      end
      if filename != nil
        @current_buffer.filename = filename
        save_buffer()
      end
    end

    def insert_file(file_path = nil)
      view_win = @frame.view_win
      if file_path == nil
        dir = @current_buffer.directory
        prefix_text = dir + "/"

        file_path = @frame.echo_gets("insert file: ", prefix_text) do |input_text|
          file_list = Dir.glob(input_text+"*")
          file_list.map{|f| File.basename(f)}.join(" ")
        end
      end
      if file_path != nil
        text = File.open(file_path).read
        view_win.sci_insert_text(view_win.sci_get_current_pos, text)
      end
    end

    def find_file(filename = nil)
      view_win = @frame.view_win

      if filename == nil
        dir = @current_buffer.directory
        filename = read_file_name("find file: ", dir)
        @frame.modeline_refresh(self)
      end
      if filename != nil
        if Mrbmacs::get_buffer_from_path(@buffer_list, filename) != nil
          switch_to_buffer(Mrbmacs::get_buffer_from_path(@buffer_list, filename).name)
        else
          @current_buffer.pos = view_win.sci_get_current_pos
          new_buffer = Buffer.new(filename, @buffer_list)
          view_win.sci_add_refdocument(@current_buffer.docpointer)
          view_win.sci_set_docpointer(nil)
          new_buffer.docpointer = view_win.sci_get_docpointer
#         new_buffer.docpointer = view_win.create_document
          @buffer_list.push(new_buffer)
          @prev_buffer = @current_buffer
          @current_buffer = new_buffer
          load_file(filename)
          view_win.sci_set_lexer_language(@current_buffer.mode.name)
          @current_buffer.mode.set_style(view_win, @theme)
          view_win.sci_set_sel_back(true, 0xff0000)
          @frame.set_buffer_name(@current_buffer.name)
#        view_win.sci_refresh
          @frame.modeline(self)
        end
      end
    end
  end
end
