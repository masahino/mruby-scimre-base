module Mrbmacs
  class Extension
  end

  # AutoCloseExtension
  class AutoCloseExtension < Extension
    BRACE_LIST = {
      '(' => ')',
      '{' => '}',
      '[' => ']'
    }.freeze
    def self.extension_id
      :auto_close
    end

    def self.register_auto_close(appl)
      appl.add_sci_event(Scintilla::SCN_CHARADDED, 10) do |app, scn|
        if BRACE_LIST.keys.include?(scn['ch'].chr('UTF-8'))
          app.frame.view_win.sci_insert_text(
            app.frame.view_win.sci_get_current_pos,
            BRACE_LIST[scn['ch'].chr('UTF-8')]
          )
        end
      end
    end
  end
end
