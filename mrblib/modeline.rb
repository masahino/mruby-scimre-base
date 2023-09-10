module Mrbmacs
  # Modeline
  class Modeline
    attr_accessor :format

    def initialize
      @format = '(#{modeline_encoding}-#{modeline_eol}):#{modeline_modified} #{modeline_buffername} #{modeline_pos}    (#{modeline_vcinfo})    [#{modeline_modename}]    [#{modeline_additional_info}]'
    end
  end

  # Application
  class Application
    def modeline_str
      # @modeline.format.gsub(/#\{([^}]*)\}/) { instance_eval(Regexp.last_match[1]).to_s }
      instance_eval("%Q\1#{@modeline.format}\1", __FILE__, __LINE__)
    end

    def modeline_format(format)
      @modeline.format = format
    end

    def modeline_encoding
      @current_buffer.encoding
    end

    def modeline_eol
      @frame.edit_win.newline
    end

    def modeline_modified
      if @frame.view_win.sci_get_modify != 0
        if @frame.view_win.sci_get_readonly != 0
          '%*'
        else
          '**'
        end
      elsif @frame.view_win.sci_get_readonly != 0
        '%%'
      else
        '--'
      end
    end

    def modeline_buffername
      @current_buffer.name
    end

    def modeline_pos
      "(#{current_col + 1},#{current_line + 1})"
    end

    def modeline_modename
      @current_buffer.mode.name
    end

    def modeline_additional_info
      @current_buffer.additional_info
    end

    def modeline_vcinfo
      @current_buffer.vcinfo.to_s
    end
  end
end
