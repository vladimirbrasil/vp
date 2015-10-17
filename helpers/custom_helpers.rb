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
        "#{@preposicoes[ word ]}"
      else
        "de"
      end
    end

    def preposicao_em(word)
      if @preposicoes && @preposicoes[ word ]
        prep_em = @preposicoes[ word ].gsub(/do/, "no").gsub(/da/, "na").gsub(/de/, "em")
        "#{prep_em}"
      else
        "em"
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
                :taxa_cem_mil_rounded,
                :atingidos,
                :circulo_pessoal,
                :eh_info_negativa

    def initialize(args={})
      utils = Utilities.new
      @crime       = args[:crime]
      @tipo_regiao = args[:tipo_regiao]
      @fonte = args[:fonte]
      @url = args[:url]
      @ano = args[:ano]
      @regiao = args[:regiao]
      @da_regiao = "#{utils.preposicao_de( regiao )} #{regiao}"
      @na_regiao = "#{utils.preposicao_em( regiao )} #{regiao}"
      @taxa_cem_mil = args[:taxa_cem_mil]
      @taxa_cem_mil_rounded = @taxa_cem_mil.to_f.round(0)

      vitimas = Vitimas.new(taxa_cem_mil: @taxa_cem_mil)
      @atingidos = vitimas.atingidos
      @circulo_pessoal = vitimas.circulo_pessoal

      #informa quando se trata de informação positiva (nenhum assassinato) ou negativa (há assassinatos) 
      @eh_info_negativa = eh_info_negativa
    end

    def eh_info_negativa
      atingidos
    end

  end

  class Vitimas
    attr_reader :atingidos, :circulo_pessoal, 
                :conhecidos, :familiares, :domicilio, :taxa_cem_mil, :expectativa_de_vida
    def initialize(args={})      
      @taxa_cem_mil = args[:taxa_cem_mil].to_f

      @conhecidos = 150
      @familiares = 30
      @domicilio = 4
      @expectativa_de_vida = 70

      @atingidos, @circulo_pessoal = _atingidos_e_circulo
    end

    def _atingidos_e_circulo
      n = _atingidos_total
      case n
      when 0..domicilio
        atingidos = domicilio/n
        circulo_pessoal = "em casa"
      when domicilio..familiares
        atingidos = familiares/n
        circulo_pessoal = "familiar"
      when @familiares..conhecidos
        atingidos = conhecidos/n
        circulo_pessoal = "amigo"
      else
        circulo_pessoal = "nenhum amigo*"
      end

      atingidos = atingidos.round if atingidos
      [atingidos, circulo_pessoal]  
    end

    def _atingidos_total
      t = taxa_cem_mil/100000
      (1-t)/(1-(1-t)**expectativa_de_vida)
    end

  end

end
