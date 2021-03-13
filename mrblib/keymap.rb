module Mrbmacs
  class KeyMap
    include Scintilla
    attr_accessor :command_list, :keymap
    def initialize()
      @command_list = {}
      @default_keymap = {
        'C-b' => SCI_CHARLEFT,
        'C-d' => SCI_CLEAR,
        'C-f' => SCI_CHARRIGHT,
        'C-g' => "keyboard-quit",
        'C-h' => SCI_DELETEBACK,
        'C-w' => "cut-region",
        'C- ' => "set-mark", # C-SPC
        'C-x u' => SCI_UNDO,
        'C-_' => SCI_UNDO,
        'C-/' => SCI_UNDO,
        'Escape' => 'prefix',
        'M-b' => SCI_WORDLEFT,
        'M-f' => SCI_WORDRIGHT,
        'M-w' => "copy-region",
        'M-<' => "beginning-of-buffer",
        'M->' => "end-of-buffer",
        'M-d' => SCI_DELWORDRIGHT,
        'M-/' => SCI_REDO,
#        'M-DEL' => SCI_DELWORDLEFT,
      }
      @keymap = {}
    end

    def set_keymap_with_key(k, v, win)
      strokes = k.split(" ").size
      #      case v.class.to_s
      if strokes == 1 and v.is_a?(Integer)
        set_keybind(win, k, v)
      else
        #      when "String"
        @command_list[k] = v
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
        if $1 == "C"
          keydef += ctrl_code << 16
        elsif $1 == "M"
          keydef += meta_code << 16
        end
        if $2 == "DEL"
          keydef += Scintilla::SCK_DELETE
        else
          if Scintilla::PLATFORM == :GTK_MACOSX
            keydef += $2.upcase.ord
          else
            keydef += $2.ord
          end
        end
      end
      win.sci_assign_cmdkey(keydef, cmd)
    end
  end

  class ViewKeyMap < KeyMap
    def initialize()
      super.initialize()
      keymap = {
        'Enter' => "newline",
        'Tab' => "indent",
#        'C-j' => "eval-last_exp",
        'C-a' => "beginning-of-line",
        'C-c' => 'prefix',
        'C-c r' => "revert-buffer",
        'C-c C-c' => "compile",
        'C-e' => "end-of-line",
        'C-k' => "kill-line",
        'C-m' => SCI_NEWLINE,
        'C-n' => SCI_LINEDOWN,
        'C-p' => SCI_LINEUP,
        'C-r' => "isearch-backward",
        'C-s' => "isearch-forward",
        'C-v' => SCI_PAGEDOWN,
        'C-x' => "prefix",
        'C-x r' => "prefix",
        'C-y' => "yank",
        'C-x b' => "switch-to-buffer",
        'C-x i' => "insert-file",
        'C-x k' => "kill-buffer",
        'C-x o' => "other-window",
        'C-x r c' => "clear-rectangle",
        'C-x r d' => "delete-rectangle",
        'C-x 0' => "delete-window",
        'C-x 1' => "delete-other-window",
        'C-x 2' => "split-window-vertically",
        'C-x 3' => "split-window-horizontally",
#        'C-x  ' => "rectangle-mark-mode",
        'C-x C-c' => "save_buffers_kill-terminal",
        'C-x C-f' => "find-file",
        'C-x C-p' => "open-project",
        'C-x C-s' => "save-buffer",
        'C-x C-w' => "write-file",
        'C-x Enter' => "prefix",
        'C-x Enter f' => "set-buffer-file-coding-system",
        'M-v' => SCI_PAGEUP,
        'M-x' => "execute-extended-command",
        'M-%' => "query-replace",
      }
      @keymap = @default_keymap.merge(keymap)
#      set_keymap(win, keymap)
    end
  end
  
  class EchoWinKeyMap < KeyMap
    def initialize()
      super.initialize()
      keymap = {
        'C-a' => SCI_HOME,
        'C-e' => SCI_LINEEND,
        'C-k' => SCI_DELLINERIGHT,
        'C-y' => SCI_PASTE,
        'Tab' => "completion",
      }
#      set_keymap(win, keymap)
      @keymap = @default_keymap.merge(keymap)
    end
  end

end
