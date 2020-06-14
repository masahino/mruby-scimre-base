module Mrbmacs
  class LispMode < Mode
    include Scintilla
    def initialize
      super
      @name = "lisp"
      @lexer = "lisp"
      @keyword_list = "not defun + - * / = < > <= >= princ \
      eval apply funcall quote identity function complement backquote lambda set setq setf \
      defun defmacro gensym make symbol intern symbol name symbol value symbol plist get \
      getf putprop remprop hash make array aref car cdr caar cadr cdar cddr caaar caadr cadar \
      caddr cdaar cdadr cddar cdddr caaaar caaadr caadar caaddr cadaar cadadr caddar cadddr \
      cdaaar cdaadr cdadar cdaddr cddaar cddadr cdddar cddddr cons list append reverse last nth \
      nthcdr member assoc subst sublis nsubst  nsublis remove length list length \
      mapc mapcar mapl maplist mapcan mapcon rplaca rplacd nconc delete atom symbolp numberp \
      boundp null listp consp minusp zerop plusp evenp oddp eq eql equal cond case and or let l if prog \
      prog1 prog2 progn go return do dolist dotimes catch throw error cerror break \
      continue errset baktrace evalhook truncate float rem min max abs sin cos tan expt exp sqrt \
      random logand logior logxor lognot bignums logeqv lognand lognor \
      logorc2 logtest logbitp logcount integer length nil"
      @style = [
        :color_foreground, #define SCE_LISP_DEFAULT 0
        :color_comment, #define SCE_LISP_COMMENT 1
        :color_foreground, #define SCE_LISP_NUMBER 2
        :color_keyword, #define SCE_LISP_KEYWORD 3
        :color_keyword, #define SCE_LISP_KEYWORD_KW 4
        :color_function_name, #define SCE_LISP_SYMBOL 5
        :color_string, #define SCE_LISP_STRING 6
        :color_string, #define SCE_LISP_STRINGEOL 8
        :color_variable_name, #define SCE_LISP_IDENTIFIER 9
        :color_foreground, #define SCE_LISP_OPERATOR 10
        :color_foreground, #define SCE_LISP_SPECIAL 11
        :color_comment, #define SCE_LISP_MULTI_COMMENT 12
          ]
    end

    def set_style(view_win, theme)
      super
      view_win.sci_set_property("fold.compact", "1")
    end

  end
end
