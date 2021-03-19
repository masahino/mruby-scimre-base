module Mrbmacs
  class Application
    def create_messages_buffer(logfile)
      find_file(logfile)
      @current_buffer.name = "*Messages*"
      @frame.set_buffer_name(@current_buffer.name)
      @current_buffer.directory = Dir.getwd
      @frame.view_win.sci_set_readonly(1)
      @frame.view_win.sci_document_end
      add_sci_event(Scintilla::SCN_FOCUSIN) do |app, scn|
        if $DEBUG
          $stderr.puts "SCN_FOCUSIN on #{app.current_buffer.name}, #{app.frame.edit_win.buffer.name}"
        end
        if app.current_buffer.name == "*Messages*"
          app.revert_buffer()
        end
      end
      switch_to_buffer "*scratch*"
    end
  end
end
