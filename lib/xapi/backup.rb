module Xapi
  # Backup gets all the problems and solutions that a user has solved.
  class Backup
    def self.restore(key)
      new(key).problems
    end

    attr_reader :key, :path
    def initialize(key, path=default_path)
      @key = key
      @path = path
    end

    def problems
      iterations.reject(&:not_found?).sort_by(&Problem::Name)
    end

    private

    def iterations
      data.map {|row|
        Iteration.new(row, Problem.new(
          track_id: row['track'],
          language: row['track'],
          slug: row['slug'],
          path: path,
          )
        )
      }
    end

    def data
      ExercismIO.code_for(key)
    end

    def default_path
      '.'
    end
  end
end
