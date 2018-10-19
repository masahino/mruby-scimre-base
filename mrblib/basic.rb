module Mrbmacs
  class Application
    def set_mark()
      @mark_pos = @frame.view_win.sci_get_current_pos
    end
    
    def copy_region()
      win = @frame.view_win
      win.sci_copy_range(@mark_pos, win.sci_get_current_pos)
      @mark_pos = nil
    end

    def cut_region()
      win = @frame.view_win
      if @mark_pos != nil
        win.sci_goto_pos(win.sci_get_current_pos - 1)
        win.sci_copy_range(@mark_pos, win.sci_get_current_pos)
        win.sci_delete_range(@mark_pos,
                             win.sci_get_current_pos - @mark_pos)
        @mark_pos = nil
      end
    end

    def kill_line()
      win = @frame.view_win
      current_pos = win.sci_get_current_pos
      line = win.sci_line_from_position(current_pos)
      line_end_pos = win.sci_get_line_end_position(line)
      if win.sci_get_line(line) != "\n"
        win.sci_copy_range(current_pos, line_end_pos)
        win.sci_delete_range(current_pos, line_end_pos-current_pos)
      else
        win.sci_line_cut
      end
    end

    def isearch_backward()
    end
    
    def isearch_forward()
    end

    def indent()
      win = @frame.view_win
      if win.sci_autoc_active == 1
        win.sci_tab
      else
        line = win.sci_line_from_position(win.sci_get_current_pos())
        level = win.sci_get_fold_level(line) & Scintilla::SC_FOLDLEVELNUMBERMASK - Scintilla::SC_FOLDLEVELBASE
        level = @current_buffer.mode.get_indent_level(win)
        indent = win.sci_get_indent()*level
        win.sci_set_line_indentation(line, indent)
        if win.sci_get_column(win.sci_get_current_pos) < indent
          win.sci_vchome
        end
      end
    end

    def beginning_of_buffer()
      win = @frame.view_win
      win.sci_document_start
    end

    def end_of_buffer()
      win = @frame.view_win
      win.sci_document_end
    end

    def newline()
      win = @frame.view_win
      if win.sci_autoc_active == 1
        win.sci_autoc_cancel
      end
      win.sci_new_line
#      indent()
    end

    def save_buffers_kill_terminal()
      @frame.exit
      exit
    end

    def keyboard_quit()
      @frame.view_win.sci_autoc_cancel
      @mark_pos = nil
    end

    def clear_rectangle()
      win = @frame.view_win
      win.sci_set_selection_mode(1)
      if @mark_pos != nil
        win.sci_set_anchor(@mark_pos)
        win.sci_replace_sel(nil, " ")
        @mark_pos = nil
        end
    end

    def delete_rectangle()
      win = @frame.view_win
      win.sci_set_selection_mode(1)
      if @mark_pos != nil
        win.sci_set_anchor(@mark_pos)
        win.sci_replace_sel(nil, "")
        @mark_pos = nil
      end
    end
  end
end
