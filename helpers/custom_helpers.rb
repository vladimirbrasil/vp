require 'json'

module CustomHelpers

  class Utilities
    PATH_PLURAIS = "data/pluralize.json"
    PATH_DICIONARIO = "data/dicionario.json"
    PATH_PREPOSICOES = "data/preposicoes.json"
    def initialize
      File.open(PATH_PLURAIS) do |file|
        @plurais = JSON.parse(file.read)
      end
      File.open(PATH_DICIONARIO) do |file|
        @dicionario = JSON.parse(file.read)
      end
      File.open(PATH_PREPOSICOES) do |file|
        @preposicoes = JSON.parse(file.read)
      end
    end

    def site_url
      site_name = File.open("source/CNAME", "r") { |f| f.read }
      "http://#{site_name}"
    end

    def site_default_tweet
      "Violência pode atingir casa, família, amigos. Veja previsões para algumas regiões"
    end

    def pluralize(value, word)
      if @plurais && @plurais[ word ]
        value.to_i > 1 ? @plurais[ word ] : word
      else
        word
      end
    end

    def dicionario(word)
      if @dicionario && @dicionario[ word ]
        @dicionario[ word ]
      else
        word
      end
    end

    def preposicao_de(word)
      if @preposicoes && @preposicoes[ word ]
        "#{@preposicoes[ word ]} #{word}"
      else
        "de #{word}"
      end
    end

    def preposicao_em(word)
      if @preposicoes && @preposicoes[ word ]
        prep_em = @preposicoes[ word ].gsub(/de/, "em").gsub(/do/, "no").gsub(/da/, "na")
        "#{prep_em} #{word}"
      else
        "em #{word}"
      end
    end    
  end

  class Stats
    attr_reader :stats
    STATS_PATH = "data/some_stats*.json"

    def initialize
      @stat_infos = Dir["data/stats/*.json"].collect do |stat_file_path|
        File.open(stat_file_path) do |stat_file|
          JSON.parse(stat_file.read)
        end
      end
      @stats = load_stats
    end

    def load_stats
      @stat_infos.collect do |stat_info|
        stat_info["stats"].collect do |rate|
          Stat.new(
              crime: stat_info["header"]["crime"],
              tipo_regiao: stat_info["header"]["tipo_regiao"],
              circulo_pessoal: stat_info["header"]["circulo_pessoal"],
              fonte: stat_info["header"]["fonte"],
              url: stat_info["header"]["url"],
              ano: stat_info["header"]["ano"],
              regiao: rate[0],
              taxa_cem_mil: rate[1]
            )
        end
      end.flatten.shuffle

    end
  end

  class Stat
    attr_reader :crime,
                :tipo_regiao,
                :fonte,
                :url,
                :ano,
                :regiao,
                :da_regiao,
                :na_regiao,
                :taxa_cem_mil,
                :atingidos,
                :circulo_pessoal,
                :eh_info_negativa

    def initialize(args={})
      @crime       = args[:crime]
      @tipo_regiao = args[:tipo_regiao]
      @fonte = args[:fonte]
      @url = args[:url]
      @ano = args[:ano]
      @da_regiao = Utilities.new.preposicao_de( args[:regiao] )
      @na_regiao = Utilities.new.preposicao_em( args[:regiao] )
      @taxa_cem_mil = args[:taxa_cem_mil]

      previsao = Previsao.new(taxa_cem_mil: @taxa_cem_mil)
      @atingidos = previsao.atingidos
      @circulo_pessoal = previsao.circulo_pessoal

      #informa quando se trata de informação positiva (nenhum assassinato) ou negativa (há assassinatos) 
      @eh_info_negativa = eh_info_negativa
    end

    def eh_info_negativa
      @atingidos
    end

  end

  class Previsao
    attr_reader :atingidos, :circulo_pessoal
    def initialize(args={})      
      @taxa_cem_mil = args[:taxa_cem_mil].to_f

      @conhecidos = 150
      @familiares = 30
      @domicilio = 4
      @expectativa_de_vida = 70

      n = atingidos_total
      case n
      when 0..@domicilio
        @atingidos = @domicilio/n
        @circulo_pessoal = "em casa"
      when @domicilio..@familiares
        @atingidos = @familiares/n
        @circulo_pessoal = "familiar"
      when @familiares..@conhecidos
        @atingidos = @conhecidos/n
        @circulo_pessoal = "conhecido"
      else
        @circulo_pessoal = "nenhum conhecido*"
      end
      @atingidos = @atingidos.round if @atingidos
    end

    def atingidos_total
      t = @taxa_cem_mil/100000
      (1-t)/(1-(1-t)**@expectativa_de_vida)
    end

    def calcular_circulo_pessoal

    end

  end

end
