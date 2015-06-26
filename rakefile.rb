require 'middleman-gh-pages'

desc "build static pages"
task :commit, :message do |t, args|
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
