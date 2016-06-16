module Mrbmacs
  class << self
    def set_mark(app)
      app.mark_pos = app.frame.view_win.sci_get_current_pos
    end
    
    def copy_region(app)
      win = app.frame.view_win
      win.sci_copy_range(app.mark_pos, win.sci_get_current_pos)
      app.mark_pos = nil
    end

    def cut_region(app)
      win = app.frame.view_win
      if app.mark_pos != nil
        win.sci_copy_range(app.mark_pos, win.sci_get_current_pos)
        win.sci_delete_range(app.mark_pos,
                             win.sci_get_current_pos - app.mark_pos)
        app.mark_pos = nil
      end
    end

    def kill_line(app)
      win = app.frame.view_win
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

    def isearch_backward(app)
    end
    
    def isearch_forward(app)
    end

    def indent(app)
      win = app.frame.view_win
      line = win.sci_line_from_position(win.sci_get_current_pos())
      level = win.sci_get_fold_level(line) & Scintilla::SC_FOLDLEVELNUMBERMASK - Scintilla::SC_FOLDLEVELBASE
      level = app.current_buffer.mode.get_indent_level(win)
      indent = win.sci_get_indent()*level
      win.sci_set_line_indentation(line, indent)
      if win.sci_get_column(win.sci_get_current_pos) < indent
        win.sci_goto_pos(win.sci_position_from_line(line)+indent)
      end
    end

    def beginning_of_buffer(app)
      win = app.frame.view_win
      win.sci_document_start
    end

    def end_of_buffer(app)
      win = app.frame.view_win
      win.sci_document_end
    end

    def newline(app)
      win = app.frame.view_win
      win.sci_new_line
      indent(app)
    end

    def save_buffers_kill_terminal(app)
      app.frame.exit
      exit
    end

    def keyboard_quit(app)
      app.mark_pos = nil
    end
  end
end
