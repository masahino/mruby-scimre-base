module Mrbmacs
  class Extension
  end

  # AutoCloseExtension
  class AutoCloseExtension < Extension
    BRACE_PAIRS = {
      '(' => ')',
      '{' => '}',
      '[' => ']'
    }.freeze
    def self.extension_id
      :auto_close
    end

    def self.register_auto_close(appl)
      appl.add_sci_event(Scintilla::SCN_CHARADDED, 10) do |app, scn|
        next unless app.current_buffer.mode.use_builtin_formatting

        count = app.frame.sci_notifications.count { |hash| hash['code'] == Scintilla::SCN_CHARADDED }
        next if count.positive?

        if BRACE_PAIRS.keys.include?(scn['ch'].chr('UTF-8'))
          app.frame.view_win.sci_insert_text(app.frame.view_win.sci_get_current_pos,
                                             BRACE_PAIRS[scn['ch'].chr('UTF-8')])
        end
      end
    end
  end
end
