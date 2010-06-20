def commit_state(comment)
  git :add => "."
  git :commit => "-am '#{comment}'"
end

def create_github_repo_and_push
  github_username = ask("What is your GitHub username?")
  github_api_token = ask("What is your GitHub API token?")
  
  private_repo = 0
  private_repo = 1 if yes?("Make #{app_name} GitHub repo private?")

  run "curl -F 'login=#{github_username}' -F 'token=#{github_api_token}' -F 'name=#{app_name}' -F 'public=#{private_repo}' http://github.com/api/v2/json/repos/create" 
  run "git remote add origin git@github.com:rswolff/#{app_name}.git"
  run 'git push origin master'
end

#remove crufty files
remove_file "README"
remove_file "public/index.html"

#gmefile
gemfile = <<-GEMFILE
  source 'http://rubygems.org'

  gem 'rails', '3.0.0.beta4'

  # Bundle edge Rails instead:
  # gem 'rails', :git => 'git://github.com/rails/rails.git'

  gem "haml", ">= 3.0.12"
  gem "compass"
  gem "capistrano"
  gem "mysql"

  # Use unicorn as the web server
  # gem 'unicorn'

  # To use debugger
  # gem 'ruby-debug'

  # Bundle the extra gems:
  # gem 'bj'
  # gem 'nokogiri', '1.4.1'
  # gem 'sqlite3-ruby', :require => 'sqlite3'
  # gem 'aws-s3', :require => 'aws/s3'

  # Bundle gems for certain environments:
  # gem 'rspec', :group => :test
  # group :test do
  #   gem 'webrat'
  # end
  
GEMFILE

remove_file "Gemfile"
create_file "Gemfile", gemfile

route("root :to => 'pages\#home'")
generate(:controller, "pages home")

#css
empty_directory "app/stylesheets"
git :clone => "--depth 0 http://github.com/joshuaclayton/blueprint-css.git public/stylesheets/blueprint"

sass_options = <<-SASS_OPTIONS
  Sass::Plugin.options[:style] = :expanded
  Sass::Plugin.options[:template_location] = 'app/stylesheets'
SASS_OPTIONS

application sass_options

#generators
empty_directory "lib/generators"
git :clone => "--depth 0 http://github.com/rswolff/rails3-app.git lib/generators"
remove_dir "lib/generators/.git"

generators = <<-GENERATORS
  config.generators do |g|
    g.template_engine :haml
  end
GENERATORS

application generators

get "http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js",  "public/javascripts/jquery.js"
get "http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.1/jquery-ui.min.js", "public/javascripts/jquery-ui.js"
get "http://github.com/rails/jquery-ujs/raw/master/src/rails.js", "public/javascripts/rails.js"

jquery = <<-JQUERY
module ActionView::Helpers::AssetTagHelper
  remove_const :JAVASCRIPT_DEFAULT_SOURCES
  JAVASCRIPT_DEFAULT_SOURCES = %w(jquery.js jquery-ui.js rails.js)

  reset_javascript_include_default
end
JQUERY

initializer "jquery.rb", jquery

layout = <<-LAYOUT
!!!
%html
  %head
    %title Testapp
    = stylesheet_link_tag 'blueprint/screen.css', :media => 'screen, projection'
    = stylesheet_link_tag 'blueprint/print.css', :media => 'print'
    /[if lt IE 8]
      = stylesheet_link_tag 'blueprint/ie.css', :media => 'screen, projection'
    = javascript_include_tag :defaults
    = csrf_meta_tag
  %body
  #container
    = yield
LAYOUT

remove_file "app/views/layouts/application.html.erb"
create_file "app/views/layouts/application.html.haml", layout

remove_file "public/index.html"

create_file "log/.gitkeep"
create_file "tmp/.gitkeep"

capify!

remove_file ".gitignore"

file '.gitignore', <<-END
.bundle
config/database.yml
log/*.log
tmp/**/*
.DS\_Store
.DS_Store
/log/*.pid
public/system/*
app/stylesheets/*
END

git :init
commit_state("initial commit")

create_github_repo_and_push if yes?("Create GitHub repository? (You'll need your API token.)")
  
docs = <<-DOCS

Run the following commands to complete the setup of #{app_name.humanize}:

% cd #{app_name}
% sudo gem install bundler
% sudo bundle install

DOCS

log docs
