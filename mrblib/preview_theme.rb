module Mrbmacs
  # Command
  module Command
    def preview_theme
      buffer_name = '*preview_theme*'
      result_buffer = Mrbmacs.get_buffer_from_name(@buffer_list, buffer_name)
      result_buffer = create_new_buffer(buffer_name) if result_buffer.nil?
      switch_to_buffer(buffer_name)
      result_buffer.docpointer = @frame.view_win.sci_get_docpointer
      @frame.view_win.sci_clear_all
      tmp_str = "#{format('%-35s', 'color_name')}  fore   back  italic  bold\n"
      @frame.view_win.sci_add_text(tmp_str.length, tmp_str)
      tmp_str = "#{'=' * 63}\n"
      @frame.view_win.sci_add_text(tmp_str.length, tmp_str)
      @current_buffer.mode.style.each_with_index do |s, i|
        color = @theme.font_color[s]
        pos = @frame.view_win.sci_get_length
        tmp_str = "#{format('%-35s', s.to_s)} #{format('%06X', color[0])} #{format('%06X', color[1])}"
        tmp_str += " #{format('%5s', color[2].to_s)}  #{format('%5s', color[3].to_s)}\n"
        @frame.view_win.sci_add_text(tmp_str.length, tmp_str)
        @frame.view_win.sci_start_styling(pos, 0)
        @frame.view_win.sci_set_styling(tmp_str.length, i)
      end
    end
  end

  # Application class
  class Application
    include Command
  end
end
