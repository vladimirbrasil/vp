=begin
xml.instruct!
xml.rss "version" => "2.0", "xmlns:content" => "http://purl.org/rss/1.0/modules/content/", "xmlns:media" => "http://search.yahoo.com/mrss/" do
  xml.channel do
    xml.title "Blog da Segurança"
    xml.link "http://www.mapadaseguranca.com/"
    xml.description "Soluções para o aparentemente insolucionável"
    xml.language "pt-BR"
    xml.lastBuildDate blog.articles.first.date.to_time.iso8601
  end

  blog.articles[0..20].each do |article|
    xml.item do
      xml.title article.title
      xml.link "rel" => "alternate", "href" => URI.join(site_url, article.url)
      xml.guid URI.join(site_url, article.url)
      xml.pubDate article.date.to_time.iso8601
      xml.updated File.mtime(article.source_file).iso8601
      xml.author { xml.name "Vladimir Bergier Dietrichkeit" } #article_author
      # xml.summary article.summary, "type" => "html"
      xml.content :encoded, article.body, "type" => "html"
    end
  end
end


<rss version='2.0' xmlns:content='http://purl.org/rss/1.0/modules/content/'>

<channel>
  <title>Blog da Segurança</title>
  <link>http://www.mapadaseguranca.com/blog.html/</link>
  <description>
  Soluções para o aparentemente insolucionável.
  </description>
  <language>pt-BR</language>
  <lastBuildDate><%= blog.articles.first.date.to_time.iso8601 %></lastBuildDate>

  <% blog.articles[0...20].each do |article| %>
    
    <item>
    <title><%= article.title %></title>
    <link><%= URI.join(site_url, article.url) %></link>
    <guid><%= URI.join(site_url, article.url) %></guid>
    <pubDate><%= article.date.to_time.iso8601 %></pubDate>
    <author>Vladimir Bergier Dietrichkeit</author>
    <description>Um artigo sobre segurança</description>
    <content:encoded>

    <!doctype html>
    <html lang="en" prefix="op: http://media.facebook.com/op#">
    <head>
    <meta charset="utf-8">
    <link rel="canonical" href="<%= URI.join(site_url, article.url) %>">
    <meta property="op:markup_version" content="v1.0">
    </head>
    <body>
    <article>
    <header>
    </header>

    <%= article.body %>

    <footer>
    </footer>
    </article>
    </body>
    </html>

    </content:encoded>
    </item>
  <% end %>

</channel>
</rss>
=end
