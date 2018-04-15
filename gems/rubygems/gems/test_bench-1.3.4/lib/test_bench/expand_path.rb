module TestBench
  class ExpandPath
    attr_reader :dir
    attr_reader :exclude_pattern
    attr_reader :root_directory

    def initialize root_directory, exclude_pattern, dir
      @dir = dir
      @exclude_pattern = exclude_pattern
      @root_directory = root_directory
    end

    def self.build root_directory, exclude_pattern=nil, dir: nil
      dir ||= Dir

      exclude_pattern ||= Settings.toplevel.exclude_pattern
      exclude_pattern = Regexp.new exclude_pattern if exclude_pattern.is_a? String

      root_directory = Pathname root_directory

      new root_directory, exclude_pattern, dir
    end

    def call pattern
      full_pattern = root_directory.join pattern

      if dir.exist? full_pattern
        full_pattern = full_pattern.join '**/*.rb'
      end

      expand full_pattern.to_s
    end

    def expand full_pattern
      dir[full_pattern].flat_map do |file|
        if exclude_pattern.match file
          []
        else
          [file]
        end
      end
    end
  end
end
