module Mrbmacs
  # Application
  class Application
    def key_scan(key_str)
      if @current_buffer.mode.keymap.key? key_str
        @current_buffer.mode.keymap[key_str]
      elsif @command_list.key? key_str
        @command_list[key_str]
      elsif @keymap.keymap.key? key_str
        @keymap.keymap[key_str]
      else
        nil
      end
    end
  end
end
