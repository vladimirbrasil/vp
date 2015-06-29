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

# use sass mixins, extends, functions...
# find arrow glyphicons for carousel at index.html
# add erb list for carousel items
# load data from yaml or other datasource | https://middlemanapp.com/advanced/data_files/
# internationalization | https://middlemanapp.com/advanced/localization/
# find how to auto-deploy from middleman to git

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
