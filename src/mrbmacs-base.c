#include <stdio.h>
#include <stdlib.h>
#include "mruby.h"
#include "mruby/class.h"
#include "mruby/data.h"
#include "mruby/string.h"
#include "mruby/array.h"
#include "mruby/variable.h"
#include "mruby/compile.h"
#include "mruby/dump.h"
#include "mruby/proc.h"

mrb_value
mrb_mrbmacs_check_syntax(mrb_state *mrb, mrb_value self)
{
  mrbc_context *c;
  struct mrb_parser_state *p;
  char *buffer_text;
  mrb_value result_array = mrb_ary_new(mrb);

  mrb_get_args(mrb, "z", &buffer_text);
  c = mrbc_context_new(mrb);
  c->no_exec = TRUE;
  c->capture_errors = TRUE;
  
  p = mrb_parse_string(mrb, buffer_text, c);
  if (p->nerr > 0) {
    mrb_ary_push(mrb, result_array, mrb_fixnum_value(p->error_buffer[0].lineno));
    mrb_ary_push(mrb, result_array, mrb_fixnum_value(p->error_buffer[0].column));
    mrb_ary_push(mrb, result_array, mrb_str_new_cstr(mrb, p->error_buffer[0].message));
  }
  mrbc_context_free(mrb, c);
  return result_array;
}

void
mrb_mruby_mrbmacs_base_gem_init(mrb_state* mrb)
{
  struct RClass *mrbmacs;

  mrbmacs = mrb_define_module(mrb, "Mrbmacs");
  mrb_define_class_method(mrb, mrbmacs, "mrb_check_syntax", mrb_mrbmacs_check_syntax, MRB_ARGS_REQ(1));
}

void
mrb_mruby_mrbmacs_base_gem_final(mrb_state* mrb)
{
}