module Mrbmacs
  class << self
    def encoding_list
      list = []
      if Iconv.method_defined?(:list)
        Iconv.list do |name|
          list.push(name)
        end
      else
        list += %w[ISO-2022-JP UTF-8 EUC-JP CP932 SHIFT_JIS]
      end
      list
    end
  end

  # define methods about encodings
  module Command
    def set_buffer_file_coding_system(code = nil)
      system_encodings = Mrbmacs.encoding_list
      if code.nil?
        code = @frame.echo_gets('Coding system for saving file:') do |input_text|
          tmp_str = input_text.upcase
          comp_list = system_encodings.select do |encoding|
            encoding.start_with?(tmp_str)
          end
          @logger.debug comp_list
          [comp_list.join(' '), input_text.length]
        end
      end
      @current_buffer.encoding = code if system_encodings.include?(code.upcase)
    end
  end

  class Application
    include Command
  end
end
