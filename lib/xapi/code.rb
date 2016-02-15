module Xapi
  # Code represents all the non-readme portions of a problem.
  class Code
    attr_reader :dir
    def initialize(dir)
      @dir = dir
    end

    def glob
      Dir.glob("#{dir}/**/*").reject { |path| File.directory?(path) }
    end

    def paths
      glob.reject { |path| path =~ /example/i }.sort
    end

    def files
      paths.each_with_object({}) {|path, files|
        files[basename(path)] = File.read(path).force_encoding("UTF-8")
      }
    end

    private

    def basename(path)
      path.gsub("#{dir}/", "")
    end
  end
end
