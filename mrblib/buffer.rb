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
  end

  class Application
    def switch_to_buffer(buffername = nil)
      view_win = @frame.view_win
      echo_win = @frame.view_win
      if buffername == nil
        buffername = @frame.select_buffer(@prev_buffer.name, @buffer_list.collect{|b| b.name})
#        echo_text = "Switch to buffer: (default #{@prev_buffer.name}) "
#        buffername = @frame.echo_gets(echo_text, "") do |input_text|
#          buffer_list = @buffer_list.collect{|b| b.name}.select{|b| b =~ /^#{input_text}/}
#          [buffer_list.join(" "), input_text.length]
#        end
      end
      if buffername != nil
        if buffername == ""
          buffername = @prev_buffer.name
        end
        if buffername == @current_buffer.name
#          echo_win.sci_set_focus(false)
          #view_win.sci_set_focus(true)
          return
        end
        new_buffer = Mrbmacs::get_buffer_from_name(@buffer_list, buffername)
        if new_buffer != nil
          @current_buffer.pos = view_win.sci_get_current_pos
          tmp_p = view_win.sci_get_docpointer
          view_win.sci_add_refdocument(@current_buffer.docpointer)
          view_win.sci_set_docpointer(new_buffer.docpointer)
          @prev_buffer = @current_buffer
          @current_buffer = new_buffer
          view_win.sci_set_lexer_language(@current_buffer.mode.name)
          @current_buffer.mode.set_style(view_win, @theme)
          view_win.sci_goto_pos(@current_buffer.pos)
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

    def kill_buffer(buffername = nil)
      if @buffer_list.size <= 1
        return
      end
      echo_text = "kill-buffer (default #{@current_buffer.name}): "
      buffername = @frame.echo_gets(echo_text, "") do |input_text|
        buffer_list = @buffer_list.collect{|b| b.name}.select{|b| b =~ /^#{input_text}/}
        [buffer_list.join(" "), input_text.length]
      end
      if buffername == ""
        buffername = @current_buffer.name
      end
      # if buffer is modified
      if @frame.view_win.sci_get_modify != 0
        ret = @frame.y_or_n("Buffer #{buffername} modified; kill anyway? (y or n) ")
        if ret == false
          return
        end
      end
      # delete buffer
      target_buffer = Mrbmacs::get_buffer_from_name(@buffer_list, buffername)
      @buffer_list.delete(target_buffer)
#      @frame.view_win.sci_release_document(target_buffer.docpointer)
      if @prev_buffer == target_buffer
        @pref_buffer = @buffer_list[0]
      end
      switch_to_buffer(@buffer_list[0].name)
    end
  end
end
