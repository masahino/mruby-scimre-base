module Mrbmacs
  class KeyMap
    include Scintilla
    attr_accessor :command_list, :keymap

    def initialize
      @command_list = {}
      @default_keymap = {
        'C-b' => SCI_CHARLEFT,
        'C-d' => SCI_CLEAR,
        'C-f' => SCI_CHARRIGHT,
        'C-g' => 'keyboard_quit',
        'C-h' => SCI_DELETEBACK,
        'C-w' => 'cut_region',
        'C- ' => 'set_mark', # C-SPC
        'C-x u' => SCI_UNDO,
        'C-_' => SCI_UNDO,
        'C-/' => SCI_UNDO,
        'Escape' => 'prefix',
        'M-b' => SCI_WORDLEFT,
        'M-f' => SCI_WORDRIGHT,
        'M-w' => 'copy_region',
        'M-<' => 'beginning_of_buffer',
        'M->' => 'end_of_buffer',
        'M-d' => SCI_DELWORDRIGHT,
        'M-/' => SCI_REDO
        # 'M-DEL' => SCI_DELWORDLEFT,
      }
      @keymap = {}
    end

    def set_keymap_with_key(key, action, win)
      strokes = key.split(' ').size
      #      case v.class.to_s
      if strokes == 1 && action.is_a?(Integer)
        set_keybind(win, key, action)
      else
        #      when "String"
        @command_list[key] = action
        #      else
        #        $stderr.puts v.class
      end
    end

    def set_keymap(win)
      @keymap.each do |k, v|
        set_keymap_with_key(k, v, win)
      end
    end

    def set_keybind(win, key, cmd)
      ctrl_code = Scintilla::SCMOD_CTRL
      meta_code = Scintilla::SCMOD_ALT
      if Scintilla::PLATFORM == :GTK_MACOSX
        ctrl_code = Scintilla::SCMOD_META
      end
      keydef = 0
      if key =~ /^(\w)-(\S)$/
        if Regexp.last_match[1] == 'C'
          keydef += ctrl_code << 16
        elsif Regexp.last_match[1] == 'M'
          keydef += meta_code << 16
        end
        if Regexp.last_match[2] == 'DEL'
          keydef += Scintilla::SCK_DELETE
        else
          if Scintilla::PLATFORM == :GTK_MACOSX
            keydef += Regexp.last_match[2].upcase.ord
          else
            keydef += Regexp.last_match[2].ord
          end
        end
      end
      win.sci_assign_cmdkey(keydef, cmd)
    end
  end

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
        'C-m' => SCI_NEWLINE,
        'C-n' => SCI_LINEDOWN,
        'C-p' => SCI_LINEUP,
        'C-r' => 'isearch_backward',
        'C-s' => 'isearch_forward',
        'C-v' => SCI_PAGEDOWN,
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
        'M-v' => SCI_PAGEUP,
        'M-x' => 'execute_extended_command',
        'M-%' => 'query-replace'
      }
      @keymap = @default_keymap.merge(keymap)
      #      set_keymap(win, keymap)
    end
  end

  class EchoWinKeyMap < KeyMap
    def initialize
      super.initialize
      keymap = {
        'C-a' => SCI_HOME,
        'C-e' => SCI_LINEEND,
        'C-k' => SCI_DELLINERIGHT,
        'C-y' => SCI_PASTE,
        'Tab' => 'completion'
      }
      #      set_keymap(win, keymap)
      @keymap = @default_keymap.merge(keymap)
    end
  end
end
