module Mrbmacs
  class RubyMode < Mode
    def initialize
      super.initialize
      @name = 'ruby'
      @lexer = 'ruby'
      @keyword_list = 'attr_accessor attr_reader attr_writer module_function begin break elsif module retry unless end case next return until class ensure nil self when def false not super while alias defined? for or then yield and do if redo true else in rescue undef'
      @start_of_comment = '# '
      @style = [
        :color_foreground, # SCE_RB_DEFAULT 0
        :color_warning, # SCE_RB_ERROR 1
        :color_comment, # SCE_RB_COMMENTLINE 2
        :color_comment, # SCE_RB_POD 3
        :color_foreground, # SCE_RB_NUMBER 4
        :color_builtin, # SCE_RB_WORD 5
        :color_string, # SCE_RB_STRING 6
        :color_string, # SCE_RB_CHARACTER 7
        :color_type, # SCE_RB_CLASSNAME 8
        :color_function_name, # SCE_RB_DEFNAME 9
        :color_foreground, # SCE_RB_OPERATOR 10
        :color_keyword, # SCE_RB_IDENTIFIER 11
        :color_regexp, # SCE_RB_REGEX 12
        :color_variable_name, # SCE_RB_GLOBAL 13
        :color_string, # SCE_RB_SYMBOL 14
        :color_preprocessor, # SCE_RB_MODULE_NAME 15
        :color_variable_name, # SCE_RB_INSTANCE_VAR 16
        :color_variable_name, # SCE_RB_CLASS_VAR 17
        :color_negation_char, # SCE_RB_BACKTICKS 18
        :color_foreground, # SCE_RB_DATASECTION 19
        :color_foreground, # SCE_RB_HERE_DELIM 20
        :color_foreground, # SCE_RB_HERE_Q 21
        :color_foreground, # SCE_RB_HERE_QQ 22
        :color_foreground, # SCE_RB_HERE_QX 23
        :color_foreground, # SCE_RB_STRING_Q 24
        :color_foreground, # SCE_RB_STRING_QQ 25
        :color_foreground, # SCE_RB_STRING_QX 26
        :color_foreground, # SCE_RB_STRING_QR 27
        :color_foreground, # SCE_RB_STRING_QW 28
        :color_foreground, # SCE_RB_WORD_DEMOTED 29
        :color_foreground, # SCE_RB_STDIN 30
        :color_foreground # SCE_RB_STDOUT 31
        #        :color_foreground, # 32
        #        :color_foreground, # 33
        #        :color_foreground, # 34
        #        :color_foreground, # 35
        #        :color_foreground, # 36
        #        :color_foreground, # 37
        #        :color_foreground, # 38
        #        :color_foreground, # 39
        #        :color_foreground, # SCE_RB_STDERR 40
        #        :color_foreground, # SCE_RB_UPPER_BOUND 41
      ]
    end

    def is_end_of_block(line)
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
