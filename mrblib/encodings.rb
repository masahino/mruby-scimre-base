module Mrbmacs
  class << self
    def get_encoding_list()
      list = []
      if Iconv.methods.include?(:list)
        Iconv.list do |name|
          list.push(name)
        end
      else
        list += ['ISO-2022-JP', 'UTF-8', 'EUC-JP', 'CP932']
      end
      list
    end
  end
    
  class Application
    def set_buffer_file_coding_system(code = nil)
      view_win = @frame.view_win
      if code == nil
        code = @frame.echo_gets("Coding system for saving file:",) do |input_text|
          tmp_str = input_text.upcase
          comp_list = @system_encodings.select do |encoding|
            encoding.start_with?(tmp_str)
          end
          if $DEBUG
            $stderr.puts comp_list
          end
          [comp_list.join(" "), input_text.length]
        end
      end
      if code != nil
        if @system_encodings.include?(code.upcase) == true
          @current_buffer.encoding = code
        end
      end
    end
  end
end
