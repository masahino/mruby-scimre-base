module Mrbmacs
  # Application
  class Application
    def insert(text = '')
      @frame.view_win.sci_insert_text(get_current_pos, text)
    end

    def set_mark
      @mark_pos = @frame.view_win.sci_get_current_pos
      @frame.view_win.sci_set_anchor(@mark_pos)
      if @frame.view_win.sci_get_move_extends_selection == 0
        @frame.view_win.sci_set_selection_mode(0)
      end
    end

    def copy_region
      @frame.view_win.sci_copy_range(@mark_pos, @frame.view_win.sci_get_current_pos)
      @frame.view_win.sci_set_empty_selection(get_current_pos)
      @mark_pos = nil
    end

    def cut_region
      win = @frame.view_win
      if @mark_pos != nil
        win.sci_goto_pos(win.sci_get_current_pos)
        win.sci_copy_range(@mark_pos, win.sci_get_current_pos)
        win.sci_delete_range(@mark_pos,
                             win.sci_get_current_pos - @mark_pos)
        @mark_pos = nil
      end
    end

    def yank
      @frame.view_win.sci_paste
    end

    def kill_line
      win = @frame.view_win
      current_pos = win.sci_get_current_pos
      line = win.sci_line_from_position(current_pos)
      line_end_pos = win.sci_get_line_end_position(line)
      if win.sci_get_line(line) != "\n"
        win.sci_copy_range(current_pos, line_end_pos)
        win.sci_delete_range(current_pos, line_end_pos - current_pos)
      else
        win.sci_line_cut
      end
    end

    def isearch_backward
    end

    def isearch_forward
    end

    def indent
      win = @frame.view_win
      if win.sci_autoc_active == 1
        current = win.sci_autoc_get_current
        win.sci_linedown
        if current == win.sci_autoc_get_current
          win.sci_vchome
        end
      else
        line = win.sci_line_from_position(win.sci_get_current_pos)
        level = @current_buffer.mode.get_indent_level(win)
        indent = win.sci_get_indent * level
        win.sci_set_line_indentation(line, indent)
        if win.sci_get_column(win.sci_get_current_pos) < indent
          win.sci_vchome
        end
      end
    end

    def beginning_of_line
      win = @frame.view_win
      win.sci_home
    end

    def end_of_line
      win = @frame.view_win
      win.sci_lineend
    end

    def beginning_of_buffer
      win = @frame.view_win
      win.sci_document_start
    end

    def end_of_buffer
      win = @frame.view_win
      win.sci_document_end
    end

    def newline
      win = @frame.view_win
      if win.sci_autoc_active == 1
        # win.sci_autoc_cancel
        win.sci_tab
      else
        win.sci_new_line
      end
    end

    def save_buffers_kill_terminal
      before_save_buffers_kill_terminal(self)
      @frame.exit
      exit
    end

    def keyboard_quit
      @frame.view_win.sci_set_empty_selection(get_current_pos)
      @frame.view_win.sci_autoc_cancel
      @mark_pos = nil
    end

    def clear_rectangle
      win = @frame.view_win
      win.sci_set_selection_mode(1)
      if @mark_pos != nil
        win.sci_set_anchor(@mark_pos)
        anchor_x = win.sci_get_column(@mark_pos)
        anchor_y = win.sci_line_from_position(@mark_pos)
        current_x = win.sci_get_column(get_current_pos)
        current_y = win.sci_line_from_position(get_current_pos)
        width = (current_x - anchor_x).abs
        lines = (current_y - anchor_y).abs + 1
        replaced_text = Array.new(lines, ' ' * width).join("\n")
        win.sci_replace_rectangular(replaced_text.length, replaced_text)
        @mark_pos = nil
      end
    end

    def delete_rectangle
      win = @frame.view_win
      win.sci_set_selection_mode(1)
      if @mark_pos != nil
        win.sci_set_anchor(@mark_pos)
        win.sci_replace_sel(nil, '')
        @mark_pos = nil
      end
    end

    def get_current_line_col(pos = nil)
      view_win = @frame.view_win
      if pos == nil
        pos = view_win.sci_get_current_pos
      end
      col = view_win.sci_get_column(pos)
      line = view_win.sci_line_from_position(pos)
      [line, col]
    end

    def get_current_line_text
      view_win = @frame.view_win
      pos = view_win.sci_get_current_pos
      line = view_win.sci_line_from_position(pos)
      view_win.sci_get_line(line)
    end

    def get_current_col
      @frame.view_win.sci_get_column(@frame.view_win.sci_get_current_pos)
    end

    def get_current_line
      @frame.view_win.sci_line_from_position(@frame.view_win.sci_get_current_pos)
    end

    def get_current_pos
      @frame.view_win.sci_get_current_pos
    end
  end
end
