=begin
Como usar

bundle exec middleman build
bundle exec middleman server

git status

git add --all
git commit -m "Calcula estatística carregando apenas taxa_cem_mil na pasta data/stats. Falta remover acentos na especificação de 'class' em '_some_stats.erb'"
git push origin master
git subtree push --prefix build origin gh-pages
=end

###
# Afazeres
###

# data
#   install all tables.
# styles
#   use sass mixins, extends, functions...
# internationalization
#   https://middlemanapp.com/advanced/localization/
# abrir ou comprar violenciometro
#   previsao para cada crime. como impostometro
#   desigualdade social do crime | negros, jovens pobres
#   https://andradetalis.wordpress.com/tag/manipulacao-de-julgamentos/
# done << find arrow glyphicons for carousel at index.html
# done << add erb list for carousel items
# done << load data from yaml or other datasource | https://middlemanapp.com/advanced/data_files/
# done << find how to auto-deploy from middleman to git

###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (https://middlemanapp.com/advanced/dynamic_pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end

require 'helpers/custom_helpers.rb'
class MyFeature < Middleman::Extension
  def initialize(app, options_hash={}, &block)
    super
  end

  helpers do
    # métooos abaixo definidos estarão disponíveis em todas as páginas.
    def utils
      CustomHelpers::Utilities.new
    end

    def site_url
      site_name = File.open("source/CNAME", "r") { |f| f.read }
      "http://#{site_name}"
    end

    def current_page_full_url
      "#{site_url}#{current_page.url}"
    end

    def site_default_tweet
      "Violência pode atingir casa, família, amigos. Veja previsões para algumas regiões"
    end

    def site_default_title
      "O mais honesto mapa da segurança brasileira. Veja previsões"
    end

  end
end

::Middleman::Extensions.register(:my_feature, MyFeature)
activate :my_feature 