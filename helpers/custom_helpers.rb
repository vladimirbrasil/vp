require 'json'

module CustomHelpers

  class CustomizeStats
    STATS_PATH = "data/some_stats.json"
    def initialize
      File.open(STATS_PATH) do |file|
        @stats_file = JSON.parse(file.read)      
      end
      @plurais =    @stats_file["pluralize"]
      # @dicionario = @stats_file["dicionario"]
      # @stats =      @stats_file["stats"]
    end

    def pluralize(value, word)
      if @plurais && @plurais[ word ]
        value.to_i > 1 ? @plurais[ word ] : word
      else
        word
      end
    end
  end

end