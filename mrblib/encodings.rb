module Mrbmacs
  class << self
    def get_encoding_list()
      `iconv -l`.split(' ')
    end
    
    def set_buffer_file_coding_system(app, code = nil)
      view_win = app.frame.view_win
      if code == nil
        code = app.frame.echo_gets("Coding system for saving file:",) do |input_text|
          tmp_str = input_text.upcase
          comp_list = app.system_encodings.select do |encoding|
            encoding.start_with?(tmp_str)
          end
          if $DEBUG
            $stderr.puts comp_list
          end
          [comp_list.join(" "), input_text.length]
        end
      end
      if code != nil
        if app.system_encodings.include?(code.upcase) == true
          app.current_buffer.encoding = code
        end
      end
    end
  end
end