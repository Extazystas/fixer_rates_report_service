module Uploaders
  class Local
    attr_reader :file_path

    def initialize(file_path)
      @file_path = file_path
    end

    def call; end
  end
end
