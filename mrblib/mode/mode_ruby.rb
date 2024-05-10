module Mrbmacs
  # ruby-mode
  class RubyMode < Mode
    def initialize
      super
      @name = 'ruby'
      @lexer = 'ruby'
      @keyword_list = 'attr_accessor attr_reader attr_writer module_function begin break elsif module retry unless end case next return until class ensure nil self when def false not super while alias defined? for or then yield and do if redo true else in rescue undef'
      @start_of_comment = '# '
      # Define styles using Scintilla constants for Ruby lexer
      @style[Scintilla::SCE_RB_DEFAULT] = :color_default
      @style[Scintilla::SCE_RB_ERROR] = :color_warning
      @style[Scintilla::SCE_RB_COMMENTLINE] = :color_comment
      @style[Scintilla::SCE_RB_POD] = :color_comment
      @style[Scintilla::SCE_RB_NUMBER] = :color_constant
      @style[Scintilla::SCE_RB_WORD] = :color_keyword
      @style[Scintilla::SCE_RB_STRING] = :color_string
      @style[Scintilla::SCE_RB_CHARACTER] = :color_string
      @style[Scintilla::SCE_RB_CLASSNAME] = :color_type
      @style[Scintilla::SCE_RB_DEFNAME] = :color_function_name
      @style[Scintilla::SCE_RB_OPERATOR] = :color_builtin
      @style[Scintilla::SCE_RB_IDENTIFIER] = :color_default
      @style[Scintilla::SCE_RB_REGEX] = :color_regexp
      @style[Scintilla::SCE_RB_GLOBAL] = :color_variable_name
      @style[Scintilla::SCE_RB_SYMBOL] = :color_string
      @style[Scintilla::SCE_RB_MODULE_NAME] = :color_type
      @style[Scintilla::SCE_RB_INSTANCE_VAR] = :color_variable_name
      @style[Scintilla::SCE_RB_CLASS_VAR] = :color_variable_name
      @style[Scintilla::SCE_RB_BACKTICKS] = :color_negation_char
      @style[Scintilla::SCE_RB_DATASECTION] = :color_default
      @style[Scintilla::SCE_RB_HERE_DELIM] = :color_default
      @style[Scintilla::SCE_RB_HERE_Q] = :color_default
      @style[Scintilla::SCE_RB_HERE_QQ] = :color_default
      @style[Scintilla::SCE_RB_HERE_QX] = :color_default
      @style[Scintilla::SCE_RB_STRING_Q] = :color_default
      @style[Scintilla::SCE_RB_STRING_QQ] = :color_default
      @style[Scintilla::SCE_RB_STRING_QX] = :color_default
      @style[Scintilla::SCE_RB_STRING_QR] = :color_default
      @style[Scintilla::SCE_RB_STRING_QW] = :color_default
      @style[Scintilla::SCE_RB_WORD_DEMOTED] = :color_default
      @style[Scintilla::SCE_RB_STDIN] = :color_default
      @style[Scintilla::SCE_RB_STDOUT] = :color_default
      @style[Scintilla::SCE_RB_STDERR] = :color_default
      @style[Scintilla::SCE_RB_STRING_W] = :color_default
      @style[Scintilla::SCE_RB_STRING_I] = :color_default
      @style[Scintilla::SCE_RB_STRING_QI] = :color_default
      @style[Scintilla::SCE_RB_STRING_QS] = :color_default
      @style[Scintilla::SCE_RB_UPPER_BOUND] = :color_default
    end

    def get_indent(view_win)
      view_win.sci_get_indent * get_indent_level(view_win)
    end

    def end_of_block?(line)
      if line =~ /^\s*(end|else|then|elsif|when|rescue|ensure|when|\}|\]|\)).*$/
        true
      else
        false
      end
    end

    def syntax_check(view_win)
      all_text = view_win.sci_get_text(view_win.sci_get_length + 1)
      Mrbmacs.mrb_check_syntax(all_text)
    end

    def get_candidates(input)
      get_candidates_a(input).join(' ')
    end

    def get_candidates_a(input)
      case input
      when /^((["'`]).*\2)\.([^.]*)$/
        # String
        receiver = $1
        message = Regexp.quote($3)

        candidates = String.instance_methods.collect { |m| m.to_s }
        select_message(receiver, message, candidates).compact.sort.uniq

      when /^(\/[^\/]*\/)\.([^.]*)$/
        # Regexp
        receiver = $1
        message = Regexp.quote($2)

        candidates = Regexp.instance_methods.collect { |m| m.to_s }
        select_message(receiver, message, candidates).compact.sort.uniq

      when /^([^\]]*\])\.([^.]*)$/
        # Array
        receiver = $1
        message = Regexp.quote($2)

        candidates = Array.instance_methods.collect { |m| m.to_s }.sort
        select_message(receiver, message, candidates).compact.sort.uniq

      when /^([^\}]*\})\.([^.]*)$/
        # Proc or Hash
        receiver = $1
        message = Regexp.quote($2)

        candidates = Proc.instance_methods.collect { |m| m.to_s }
        candidates |= Hash.instance_methods.collect { |m| m.to_s }.sort
        select_message(receiver, message, candidates).compact.sort.uniq

      when /^(:[^:.]*)$/
        # Symbol
        if Symbol.respond_to?(:all_symbols)
          sym = $1
          candidates = Symbol.all_symbols.collect { |s| ':' + s.id2name }
          candidates.grep(/^#{Regexp.quote(sym)}/).sort
        else
          []
        end

      when /^::([A-Z][^:\.\(]*)$/
        # Absolute Constant or class methods
        receiver = $1
        candidates = Object.constants.collect { |m| m.to_s }
        candidates.grep(/^#{receiver}/).collect { |e| '::' + e }.compact.sort.uniq

      when /^([A-Z].*)::([^:.]*)$/
        # Constant or class methods
        receiver = $1
        message = Regexp.quote($2)
        begin
          candidates = eval("#{receiver}.constants.collect{|m| m.to_s}")
          candidates |= eval("#{receiver}.methods.collect{|m| m.to_s}").sort
        rescue StandardError
          candidates = []
        end
        select_message(receiver, message, candidates, '::').compact.sort.uniq

      when /^(:[^:.]+)(\.|::)([^.]*)$/
        # Symbol
        receiver = $1
        sep = $2
        message = Regexp.quote($3)

        candidates = Symbol.instance_methods.collect { |m| m.to_s }
        select_message(receiver, message, candidates, sep).compact.sort.uniq

      when /^(-?(0[dbo])?[0-9_]+(\.[0-9_]+)?([eE]-?[0-9]+)?)(\.|::)([^.]*)$/
        # Numeric
        receiver = $1
        sep = $5
        message = Regexp.quote($6)

        begin
          candidates = eval(receiver).methods.collect { |m| m.to_s }
        rescue StandardError
          candidates = []
        end
        select_message(receiver, message, candidates, sep).compact.sort.uniq

      when /^(-?0x[0-9a-fA-F_]+)(\.|::)([^.]*)$/
        # Numeric(0xFFFF)
        receiver = $1
        sep = $2
        message = Regexp.quote($3)

        begin
          candidates = eval(receiver).methods.collect { |m| m.to_s }.sort
        rescue StandardError
          candidates = []
        end
        select_message(receiver, message, candidates, sep)

      when /^(\$[^.]*)$/
        # global var
        regmessage = Regexp.new(Regexp.quote($1))
        candidates = global_variables.collect { |m| m.to_s }.grep(regmessage).sort

      when /^([^."].*)(\.|::)([^.]*)$/
        # variable.func or func.func
        receiver = $1
        sep = $2
        message = Regexp.quote($3)

        gv = eval('global_variables').collect { |m| m.to_s }
        lv = eval('local_variables').collect { |m| m.to_s }
        iv = eval('instance_variables').collect { |m| m.to_s }
        cv = eval('Object.constants').collect { |m| m.to_s }

        if (gv | lv | iv | cv).include?(receiver) || /^[A-Z]/ =~ receiver && /\./ !~ receiver
          # foo.func and foo is var. OR
          # foo::func and foo is var. OR
          # foo::Const and foo is var. OR
          # Foo::Bar.func
          begin
            candidates = []
            rec = eval(receiver)
            if sep == '::' && rec.kind_of?(Module)
              candidates = rec.constants.collect { |m| m.to_s }
            end
            candidates |= rec.methods.collect { |m| m.to_s }
            candidates.sort!
            candidates.uniq!
          rescue StandardError
            candidates = []
          end
        else
          # func1.func2
          candidates = []
          ObjectSpace.each_object(Module) do |m|
            begin
              name = m.name
            rescue StandardError
              name = ''
            end
            begin
              next if name != 'IRB::Context' &&
              /^(IRB|SLex|RubyLex|RubyToken)/ =~ name
            rescue StandardError
              next
            end
            candidates.concat m.instance_methods(false).collect { |x| x.to_s }
          end
          candidates.sort!
          candidates.uniq!
        end
        select_message(receiver, message, candidates, sep).compact.sort.uniq

      when /^\.([^.]*)$/
        # unknown(maybe String)

        receiver = ''
        message = Regexp.quote($1)

        candidates = String.instance_methods(true).collect { |m| m.to_s }
        select_message(receiver, message, candidates).compact.sort.uniq

      else
        candidates = eval('methods | private_methods | local_variables | instance_variables | Object.constants').collect { |m| m.to_s }
        reserved_words = @keyword_list.split(' ')
        (candidates | reserved_words).grep(/^#{Regexp.quote(input)}/).sort
      end
    end

    # Set of available operators in Ruby
    Operators = %w[% & * ** + - / < << <= <=> == === =~ > >= >> [] []= ^ ! != !~]

    def select_message(receiver, message, candidates, sep = '.')
      candidates.grep(/^#{message}/).collect do |e|
        case e
        when /^[a-zA-Z_]/
          receiver + sep + e
        when /^[0-9]/
        when *Operators
          # receiver + " " + e
        end
      end
    end
  end
end
