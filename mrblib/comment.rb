module Mrbmacs
  # Application class
  class Application
    def comment_line
      @frame.view_win.sci_begin_undo_action
      line = @frame.view_win.sci_line_from_position(@frame.view_win.sci_get_current_pos)
      start_of_line = @frame.view_win.sci_position_from_line(line) +
                      @frame.view_win.sci_get_line_indentation(line)
      @frame.view_win.sci_insert_text(start_of_line, @current_buffer.mode.start_of_comment)
      end_of_line = @frame.view_win.sci_get_line_end_position(line)
      @frame.view_win.sci_insert_text(end_of_line, @current_buffer.mode.end_of_comment)
      @frame.view_win.sci_end_undo_action
    end

    def uncomment_line
      @frame.view_win.sci_begin_undo_action
      line = get_current_line
      line_text = get_current_line_text
      pattern1 = Regexp.escape(@current_buffer.mode.start_of_comment)
      pattern2 = Regexp.escape(@current_buffer.mode.end_of_comment)
      if line_text =~ /^\s*#{pattern1}.*#{pattern2}$/
        end_of_line = @frame.view_win.sci_get_line_end_position(line)
        if @current_buffer.mode.end_of_comment.size > 0
          @frame.view_win.sci_delete_range(end_of_line - @current_buffer.mode.end_of_comment.size,
                                           @current_buffer.mode.end_of_comment.size)
        end
        start_of_line = @frame.view_win.sci_position_from_line(line) +
                        @frame.view_win.sci_get_line_indentation(line)
        @frame.view_win.sci_delete_range(start_of_line, @current_buffer.mode.start_of_comment.size)
      end
      @frame.view_win.sci_end_undo_action
    end
  end
end
