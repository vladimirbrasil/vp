  class Stat
    def initialize(args={})
      @crime       = args[:crime]
      @tipo_regiao = args[:tipo_regiao]
      @fonte = args[:fonte]
      @url = args[:url]
      @ano = args[:ano]
      @regiao = args[:regiao]
      @taxa_cem_mil = args[:taxa_cem_mil].to_f

      previsao = Previsao.new(taxa_cem_mil: @taxa_cem_mil)
      @atingidos = previsao.atingidos
      @circulo_pessoal = previsao.circulo_pessoal
    end


  end

  class Previsao
    attr_reader :atingidos, :circulo_pessoal
    def initialize(args={})
      @taxa_cem_mil = args[:taxa_cem_mil]

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