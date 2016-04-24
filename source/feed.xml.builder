xml.instruct!
xml.feed "xmlns" => "http://www.w3.org/2005/Atom" do
  site_url = "http://www.mapadaseguranca.com/"
  xml.title "Blog da Segurança"
  xml.subtitle "Soluções para o aparentemente insolucionável"
  xml.id URI.join(site_url, blog.options.prefix.to_s)
  xml.link "href" => URI.join(site_url, blog.options.prefix.to_s)
  xml.link "href" => URI.join(site_url, current_page.path), "rel" => "self"
  xml.updated(blog.articles.first.date.to_time.iso8601) unless blog.articles.empty?
  xml.author { xml.name "Vladimir Bergier Dietrichkeit" }


  blog.articles[0..20].each do |article|
=begin
    # Não consigo adicionar versão. 
    # Somente reconhece propriedades pré-definidas (title, tag, etc).
    # Não reocnhece "version" nem "author" (respond_to=>false!)
    # Preciso adicionar versão no xml.id para atualizar newstand em cada nova versão!
    # article_author = find_author(article.author) if article.author
    puts article.inspect
    article_version = article.respond_to?("version") ? article.version : ''
    puts article_version
    puts article.respond_to?("author")
=end
    xml.entry do
      xml.title article.title
      xml.link "rel" => "alternate", "href" => URI.join(site_url, article.url)
      xml.id URI.join(site_url, article.url)
      xml.published article.date.to_time.iso8601
      xml.updated File.mtime(article.source_file).iso8601
      xml.author { xml.name "Vladimir Bergier Dietrichkeit" } #article_author
      # xml.summary article.summary, "type" => "html"
      xml.content article.body, "type" => "html"
    end
  end
end
