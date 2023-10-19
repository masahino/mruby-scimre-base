module Mrbmacs
  # Application
  class Application
    def key_scan(key_str)
      if @current_buffer.mode.keymap.key? key_str
        @current_buffer.mode.keymap[key_str]
      else
        @keymap.keymap[key_str]
      end
    end

    def modify_keymap(key, cmd)
      @keymap.keymap[key] = cmd
    end
  end
end
