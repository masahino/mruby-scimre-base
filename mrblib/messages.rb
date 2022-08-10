module Mrbmacs
  class Application
    def create_messages_buffer(logfile)
      find_file(logfile)
      @current_buffer.name = '*Messages*'
      @frame.set_buffer_name(@current_buffer.name)
      @current_buffer.directory = Dir.getwd
      @frame.view_win.sci_set_readonly(1)
      @frame.view_win.sci_document_end
      add_sci_event(Scintilla::SCN_FOCUSIN) do |app, _scn|
        app.revert_buffer if app.current_buffer.name == '*Messages*'
      end
      switch_to_buffer '*scratch*'
    end
  end
end
