module Mrbmacs
  class Buffer
    attr_accessor :filename, :directory, :docpointer, :name, :encoding, :mode, :pos
    def initialize(filename = nil, buffer_name_list = [])
      if filename != nil
        @filename = File.expand_path(filename)
        @name = create_new_buffer_name(@filename, buffer_name_list)
        #@name = File.basename(@filename)
        @directory = File.dirname(@filename)
        @mode = Mrbmacs::Mode.set_mode_by_filename(filename)
      else
        @filename = ""
        @name = ""
        @directory = Dir.getwd
        @mode = Mrbmacs::Mode.new
      end
      text = ""
      @encoding = "utf-8"
      @docpointer = nil
      @pos = 0
    end

    def create_new_buffer_name(filename, buffer_name_list)
      buffer_name = File.basename(filename)
      dir = File.dirname(filename).split("/")
      tmp_str = ""
      while buffer_name_list.include?(buffer_name)
        if tmp_str == ""
          tmp_str = dir.pop
        else
          tmp_str = dir.pop + "/" + tmp_str
        end
        buffer_name = File.basename(filename) + "<" + tmp_str + ">"
      end
      return buffer_name
    end
  end

  class << self
    def get_buffer_from_name(buffer_list, name)
      buffer_list.each do |b|
        if b.name == name
          return b
        end
      end
      return nil
    end

    def switch_to_buffer(app, buffername = nil)
      view_win = app.frame.view_win
      echo_win = app.frame.view_win
      if buffername == nil
        echo_text = "Switch to buffer: (default #{app.prev_buffer.name}) "
        buffername = app.frame.echo_gets(echo_text, "") do |input_text|
          buffer_list = app.buffer_list.collect{|b| b.name}.select{|b| b =~ /^#{input_text}/}
          [buffer_list.join(" "), input_text.length]
        end
      end
      if buffername != nil
        if buffername == ""
          buffername = app.prev_buffer.name
        end
        if buffername == app.current_buffer.name
#          echo_win.sci_set_focus(false)
          #view_win.sci_set_focus(true)
          return
        end
        new_buffer = get_buffer_from_name(app.buffer_list, buffername)
        if new_buffer != nil
          app.current_buffer.pos = view_win.sci_get_current_pos
          tmp_p = view_win.sci_get_docpointer
          view_win.sci_add_refdocument(app.current_buffer.docpointer)
          view_win.sci_set_docpointer(new_buffer.docpointer)
          app.prev_buffer = app.current_buffer
          app.current_buffer = new_buffer
          view_win.sci_set_lexer_language(app.current_buffer.mode.name)
          app.current_buffer.mode.set_style(view_win, app.theme)
          view_win.sci_goto_pos(app.current_buffer.pos)
        end
        #echo_win.sci_set_focus(false)
        #echo_win.refresh
        #view_win.sci_set_focus(true)
        
#        mode = Mrbmacs::Mode.set_mode_by_filename(filename)
#        view_win.set_lexer_language(mode.name)
#        mode.set_style(view_win)
#        view_win.set_sel_back(true, 0xff0000)
        #view_win.refresh

      end
    end

    def kill_buffer(app)
      echo_text = "kill-buffer (default #{app.current_buffer.name}): "
      buffername = app.frame.echo_gets(echo_text, "") do |input_text|
      end
      if echo_text == nil
        buffername = app.current_buffer.name
      end
    end
  end
end
