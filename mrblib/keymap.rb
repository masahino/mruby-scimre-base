module Mrbmacs
  # KeyMap
  class KeyMap
    attr_accessor :keymap

    def initialize
      @default_keymap = {
        'C-b' => Scintilla::SCI_CHARLEFT,
        'C-d' => Scintilla::SCI_CLEAR,
        'C-f' => Scintilla::SCI_CHARRIGHT,
        'C-g' => 'keyboard_quit',
        'C-h' => Scintilla::SCI_DELETEBACK,
        'C-w' => 'cut_region',
        'C- ' => 'set_mark', # C-SPC
        'C-x u' => Scintilla::SCI_UNDO,
        'C-_' => Scintilla::SCI_UNDO,
        'C-/' => Scintilla::SCI_UNDO,
        'Escape' => 'prefix',
        'M-b' => Scintilla::SCI_WORDLEFT,
        'M-f' => Scintilla::SCI_WORDRIGHT,
        'M-w' => 'copy_region',
        'M-<' => 'beginning_of_buffer',
        'M->' => 'end_of_buffer',
        'M-d' => Scintilla::SCI_DELWORDRIGHT,
        'M-/' => Scintilla::SCI_REDO
        # 'M-DEL' => Scintilla::SCI_DELWORDLEFT,
      }
      @keymap = {}
    end
  end

  # KeyMap for a view window
  class ViewKeyMap < KeyMap
    def initialize
      super.initialize
      keymap = {
        'Enter' => 'newline',
        'Tab' => 'indent',
        # 'F3' => 'start_keyboard_macro',
        # 'C-j' => "eval-last_exp",
        'C-a' => 'beginning_of_line',
        'C-c' => 'prefix',
        'C-c r' => 'revert_buffer',
        'C-c C-c' => 'compile',
        'C-e' => 'end_of_line',
        'C-k' => 'kill_line',
        'C-l' => 'recenter',
        'C-m' => Scintilla::SCI_NEWLINE,
        'C-n' => Scintilla::SCI_LINEDOWN,
        'C-p' => Scintilla::SCI_LINEUP,
        'C-r' => 'isearch_backward',
        'C-s' => 'isearch_forward',
        'C-t' => 'dmacro_exec',
        'C-v' => Scintilla::SCI_PAGEDOWN,
        'C-x' => 'prefix',
        'C-x r' => 'prefix',
        'C-y' => 'yank',
        'C-x b' => 'switch_to_buffer',
        'C-x i' => 'insert_file',
        'C-x k' => 'kill_buffer',
        'C-x o' => 'other_window',
        'C-x r c' => 'clear_rectangle',
        'C-x r d' => 'delete_rectangle',
        'C-x 0' => 'delete_window',
        'C-x 1' => 'delete_other_window',
        'C-x 2' => 'split_window_vertically',
        'C-x 3' => 'split_window_horizontally',
        # 'C-x  ' => 'rectangle-mark-mode',
        'C-x C-c' => 'save_buffers_kill_terminal',
        'C-x C-f' => 'find_file',
        'C-x C-p' => 'open_project',
        'C-x C-s' => 'save_buffer',
        'C-x C-w' => 'write_file',
        'C-x Enter' => 'prefix',
        'C-x Enter f' => 'set_buffer_file_coding_system',
        'C-x ^' => 'enlarge_window',
        'C-x }' => 'enlarge_window_horizontally',
        'M-l' => 'downcase_word',
        'M-u' => 'upcase_word',
        'M-v' => Scintilla::SCI_PAGEUP,
        'M-x' => 'execute_extended_command',
        'M-%' => 'query-replace'
      }
      @keymap = @default_keymap.merge(keymap)
    end
  end

  # Keymap for a echo window
  class EchoWinKeyMap < KeyMap
    def initialize
      super.initialize
      keymap = {
        'C-a' => Scintilla::SCI_HOME,
        'C-e' => Scintilla::SCI_LINEEND,
        'C-k' => Scintilla::SCI_DELLINERIGHT,
        'C-y' => Scintilla::SCI_PASTE,
        'Tab' => 'completion'
      }
      @keymap = @default_keymap.merge(keymap)
    end
  end

  # Application class for Keymap
  class Application
    def init_keymap
      @keymap = ViewKeyMap.new
      apply_keymap(@frame.view_win, @keymap)
      @echo_keymap = EchoWinKeyMap.new
      apply_keymap(@frame.echo_win, @echo_keymap)
    end

    def set_keybind(win, key, cmd)
      ctrl_code = Scintilla::SCMOD_CTRL
      meta_code = Scintilla::SCMOD_ALT
      ctrl_code = Scintilla::SCMOD_META if Scintilla::PLATFORM == :GTK_MACOSX
      keydef = 0
      key_parts = key.split('-')
      if key_parts.length == 2
        case key_parts[0]
        when 'C'
          keydef += ctrl_code << 16
        when 'M'
          keydef += meta_code << 16
        end
        if key_parts[1] == 'DEL'
          keydef += Scintilla::SCK_DELETE
        else
          if Scintilla::PLATFORM == :GTK_MACOSX
            keydef += key_parts[1].upcase.ord
          else
            keydef += key_parts[1].ord
          end
        end
      end
      win.sci_assign_cmdkey(keydef, cmd)
    end

    def apply_keymap(win, keymap)
      keymap.keymap.each do |key, action|
        set_keybind(win, key, action) if action.is_a?(Integer) && !key.include?(' ')
      end
    end
  end
end
