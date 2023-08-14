module Mrbmacs
  # *scratch *
  class IrbMode < RubyMode
    def initialize
      super.initialize
      @name = 'irb'
      @keymap['C-j'] = 'eval_last_exp'
    end
  end
end
