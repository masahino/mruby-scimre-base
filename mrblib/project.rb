module Mrbmacs
  class Project
    attr_reader :root_directory
    attr_accessor :build_command, :last_build_command
    def initialize(root_directory)
      @root_directory = root_directory
      @build_command = guess_build_command
      @last_build_command = nil
    end

    def guess_build_command
      build_types = {'Rakefile' => 'rake',
        'Makefile' => 'make',
        'build.sh' => './build.sh'}
      build_types.each do |k, v|
        if File.exist?(@root_directory + "/" + k)
          return v
        end
      end
      return 'make'
    end
  end

  class Application
    def open_project(root_directory = nil)
      if root_directory == nil
        root_directory = read_dir_name("Project directory: ", @current_buffer.directory)
      end
      if root_directory != nil and Dir.exist?(root_directory)
        @project.root_directory = root_directory
        Dir.chdir(@project.root_directory)
      end
    end
  end
end
