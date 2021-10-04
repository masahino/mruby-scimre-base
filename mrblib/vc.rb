module Mrbmacs
  class VC
    def initialize(directory)
      @type = 'git'
      @branch = `git -C #{directory} branch --show-current 2> /dev/null`.chomp
    end

    def to_s
      if @branch != ''
        "Git:#{@branch}"
      else
        @branch
      end
    end
  end
  class Application
  end
end
