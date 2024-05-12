module Mrbmacs
  # KeyMap
  class KeyMap
    attr_accessor :keymap

    def initialize
      @keymap = {
        'C-b' => Scintilla::SCI_CHARLEFT,
        'C-d' => Scintilla::SCI_CLEAR,
        'C-f' => Scintilla::SCI_CHARRIGHT,
        'C-g' => 'keyboard_quit',
        'C-h' => Scintilla::SCI_DELETEBACK,
        'C-n' => Scintilla::SCI_LINEDOWN,
        'C-p' => Scintilla::SCI_LINEUP,
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
    end

    def update_keybinding(key, action)
      @keymap[key] = action
    end
  end

  # KeyMap for a view window
  class ViewKeyMap < KeyMap
    def initialize
      super
      update_keybinding('Enter', 'newline')
      update_keybinding('Tab', 'indent')
      update_keybinding('C-a', 'beginning_of_line')
      update_keybinding('C-c', 'prefix')
      update_keybinding('C-c r', 'revert_buffer')
      update_keybinding('C-c C-c', 'compile')
      update_keybinding('C-e', 'end_of_line')
      update_keybinding('C-k', 'kill_line')
      update_keybinding('C-l', 'recenter')
      update_keybinding('C-m', Scintilla::SCI_NEWLINE)
      update_keybinding('C-n', Scintilla::SCI_LINEDOWN)
      update_keybinding('C-p', Scintilla::SCI_LINEUP)
      update_keybinding('C-r', 'isearch_backward')
      update_keybinding('C-s', 'isearch_forward')
      update_keybinding('C-t', 'dmacro_exec')
      update_keybinding('C-v', Scintilla::SCI_PAGEDOWN)
      update_keybinding('C-x', 'prefix')
      update_keybinding('C-x r', 'prefix')
      update_keybinding('C-y', 'yank')
      update_keybinding('C-x b', 'switch_to_buffer')
      update_keybinding('C-x i', 'insert_file')
      update_keybinding('C-x k', 'kill_buffer')
      update_keybinding('C-x o', 'other_window')
      update_keybinding('C-x r c', 'clear_rectangle')
      update_keybinding('C-x r d', 'delete_rectangle')
      update_keybinding('C-x 0', 'delete_window')
      update_keybinding('C-x 1', 'delete_other_window')
      update_keybinding('C-x 2', 'split_window_vertically')
      update_keybinding('C-x 3', 'split_window_horizontally')
      update_keybinding('C-x C-c', 'save_buffers_kill_terminal')
      update_keybinding('C-x C-f', 'find_file')
      update_keybinding('C-x C-p', 'open_project')
      update_keybinding('C-x C-s', 'save_buffer')
      update_keybinding('C-x C-w', 'write_file')
      update_keybinding('C-x Enter', 'prefix')
      update_keybinding('C-x Enter f', 'set_buffer_file_coding_system')
      update_keybinding('C-x ^', 'enlarge_window')
      update_keybinding('C-x }', 'enlarge_window_horizontally')
      update_keybinding('M-l', 'downcase_word')
      update_keybinding('M-u', 'upcase_word')
      update_keybinding('M-v', Scintilla::SCI_PAGEUP)
      update_keybinding('M-x', 'execute_extended_command')
      update_keybinding('M-%', 'query-replace')
    end
  end

  # Keymap for a echo window
  class EchoWinKeyMap < KeyMap
    def initialize
      super
      update_keybinding('C-a', Scintilla::SCI_HOME)
      update_keybinding('C-e', Scintilla::SCI_LINEEND)
      update_keybinding('C-k', Scintilla::SCI_DELLINERIGHT)
      update_keybinding('C-y', Scintilla::SCI_PASTE)
      update_keybinding('Tab', 'completion')
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
      ctrl_code = Scintilla::SCMOD_CTRL << 16
      meta_code = Scintilla::SCMOD_ALT << 16
      ctrl_code = Scintilla::SCMOD_META << 16 if Scintilla::PLATFORM == :GTK_MACOSX
      keydef = 0

      key_parts = key.split('-')
      if key_parts.length == 2
        mod, key_char = key_parts
        keydef += ctrl_code if mod == 'C'
        keydef += meta_code if mod == 'M'

        if key_char == 'DEL'
          keydef += Scintilla::SCK_DELETE
        else
          key_char.upcase! if Scintilla::PLATFORM == :GTK_MACOSX
          keydef += key_char.ord
        end
      else
        key.upcase! if Scintilla::PLATFORM == :GTK_MACOSX
        keydef = key.ord
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
