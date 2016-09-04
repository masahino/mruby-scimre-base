module Mrbmacs
  class KeyMap
    include Scintilla
    attr_accessor :command_list
    def initialize(win)
      @command_list = {}
      keymap = {
        'C-a' => SCI_HOME,
        'C-b' => SCI_CHARLEFT,
        'C-d' => SCI_CLEAR,
        'C-e' => SCI_LINEEND,
        'C-f' => SCI_CHARRIGHT,
        'C-g' => "keyboard-quit",
        'C-h' => SCI_DELETEBACK,
        'C-k' => "kill-line",
        'C-w' => "cut-region",
        'C-y' => SCI_PASTE,
        'C-@' => "set-mark", # C-SPC
        'C-x u' => SCI_UNDO,
        'Escape' => 'prefix',
        'M-w' => "copy-region",
        'M-<' => "beginning-of-buffer",
        'M->' => "end-of-buffer",
      }
      set_keymap(win, keymap)
    end
    
    def set_keymap(win, keymap)
      keymap.each do |k, v|
        strokes = k.split(" ").size
        #      case v.class.to_s
        if strokes == 1 and v.class.to_s == "Fixnum" 
          set_keybind(win, k, v)
        else
          #      when "String"
          @command_list[k] = v
          #      else
          #        $stderr.puts v.class
        end
      end
    end

    def set_keybind(win, key, cmd)
      ctrl_code = Scintilla::SCMOD_CTRL
      meta_code = Scintilla::SCMOD_ALT
      if Scintilla::PLATFORM == :GTK_MACOSX
        ctrl_code = Scintilla::SCMOD_META
      end
      keydef = 0
      if key =~ /^(\w)-(\w)$/
        if $1 == "C"
          keydef += ctrl_code << 16
        elsif $1 == "M"
          keydef += meta_code << 16
        end
        if Scintilla::PLATFORM == :GTK_MACOSX
          keydef += $2.upcase.ord
        else
          keydef += $2.ord
        end
      end
      win.sci_assign_cmdkey(keydef, cmd)
    end
  end

  class ViewKeyMap < KeyMap
    def initialize(win)
      super.initialize(win)
      keymap = {
        'Enter' => "newline",
        'Tab' => "indent",
#        'C-j' => "eval-last_exp",
        'C-m' => SCI_NEWLINE,
        'C-n' => SCI_LINEDOWN,
        'C-p' => SCI_LINEUP,
        'C-r' => "isearch-backward",
        'C-s' => "isearch-forward",
        'C-v' => SCI_PAGEDOWN,
        'C-x' => "prefix",
        'C-y' => SCI_PASTE,
        'C-x b' => "switch-to-buffer",
        'C-x i' => "insert-file",
        'C-x k' => "kill-buffer",
        'C-x C-c' => "save_buffers_kill-terminal",
        'C-x C-f' => "find-file",
        'C-x C-s' => "save-buffer",
        'C-x C-w' => "write-file",
        'C-x Enter' => "prefix",
        'C-x Enter f' => "set-buffer-file-coding-system",
        'M-v' => SCI_PAGEUP,
        'M-x' => "execute-extended-command",
      }
      set_keymap(win, keymap)
    end
  end
  
  class EchoWinKeyMap < KeyMap
    def initialize(win)
      super.initialize(win)
      keymap = {
        'Tab' => "completion",
      }
      set_keymap(win, keymap)
    end
  end
end
