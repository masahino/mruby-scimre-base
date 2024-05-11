module Mrbmacs
  # *scratch *
  class IrbMode < RubyMode
    def initialize
      super
      @name = 'irb'
      @keymap['C-j'] = 'eval_last_exp'
    end
  end
end
