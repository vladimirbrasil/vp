require 'middleman-gh-pages'

desc "build static pages"
task :commit, :message do |t, args|
  #rake commit["Mensagem do commit"]
  message = args[:message] || "New commit"

  p "## Adding, commiting and pushing static pages"
  system "bundle exec middleman build"
  system "git add --all"
  system "git commit -m '#{message}'"
  system "git push origin master"
end

desc "deploy to github pages"
task :deploy, :message do |t, args|
  message = args[:message] || "Site updated at #{Time.now.utc}"
  Rake::Task[:commit].invoke(message)

  p "## Deploying to Github Pages"
  system "git subtree push --prefix build origin gh-pages"
end

=begin
Afazeres
Facebook+Twitter share links with images (Decio).
  Twitter card | https://dev.twitter.com/cards/types/summary-large-image

https://www.crimereports.com/
https://docs.google.com/file/d/0B8_Gi38zQm7aSUxMX21yUjlmeDA/edit
novos dominios azedu.me ferrou.me ferrou.com 
salve.ninja semsaida.eu ajuda.io (br.io)
mapadaseguranca.com

Adicionar em
_head.erb
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
  
custom_helpers.rb
    def preposicao_em(word)
      if @preposicoes && @preposicoes[ word ]
        prep_em = @preposicoes[ word ].gsub(/de/, "em")
        prep_em = @preposicoes[ word ].gsub(/do/, "no")
        prep_em = @preposicoes[ word ].gsub(/da/, "na")
        "#{prep_em} #{word}"
      else
        "em #{word}"
      end
    end
    #...
    @na_regiao = Utilities.new.preposicao_em( args[:regiao] )

_some_stats.rb
      <ul class="list-inline">

        <li><a  href="http://violencia.click" 
                class="fb-share icon icon-facebook" data-caption="Segurança Pública" 
                data-description="Com as taxas de violência atuais é esperado ao longo da vida que 
                                  <%= "#{stat.atingidos} #{utils.pluralize(stat.atingidos, stat.circulo_pessoal)}" %> 
                                  <%= utils.pluralize(stat.atingidos, "sofra") %> 
                                  <%= utils.dicionario(  stat.crime  ) %> 
                                  <%= stat.na_regiao %>. 
                                  Proteste.">
                <span class="fa fa-facebook"></span>
                <span class="sr-only">Compartilhar no Facebook</span></a></li>

        <li><a  href="https://twitter.com/intent/tweet?
                     url=http%3A%2F%2Fviolencia.click;
                     text=Com as taxas atuais ao longo da vida é esperado que 1 familiar sofra assassinato em Alagoas. Proteste." 
                target="_blank" class="tw-share icon icon-twitter popup">
                <span class="fa fa-twitter"></span>
                <span class="sr-only">Compartilhar no Twitter</span></a></li>

        <li><a  href="https://plus.google.com/share?
                      url=http%3A%2F%2Fviolencia.click" 
                target="_blank" class="gp-share icon icon-gplus popup">
                <span class="fa fa-google-plus"></span>
                <span class="sr-only">Compartilhar no Google Plus</span></a></li>

        <li><a  href="whatsapp://send?
                      text=Com as taxas de violência atuais é esperado ao longo da vida que 1 familiar sofra assassinato em Alagoas. Proteste.  http%3A%2F%2Fviolencia.click" 
                target="_blank" class="ws-share icon icon-whatsapp">
                <span class="fa fa-whatsapp"></span>
                <span class="sr-only">Compartilhar no WhatsApp</span></a></li>

      </ul>


=end
