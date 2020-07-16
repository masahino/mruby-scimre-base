module Mrbmacs
  class Application
    def key_scan(key_str)
      if @current_buffer.mode.keymap.has_key? key_str
        @current_buffer.mode.keymap[key_str]
      elsif @command_list.has_key? key_str
        @command_list[key_str]
      else
        nil
      end
    end
  end
end