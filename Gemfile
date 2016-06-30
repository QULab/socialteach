source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'tzinfo-data'
gem 'rails', '4.2.0'
gem 'mysql2', '~> 0.3.21'
gem 'devise', '~> 3.2'
gem 'activeadmin', '~> 1.0.0.pre2'
gem 'puma'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
gem 'bootstrap-sass', '~> 3.3'
gem 'bootstrap_form'
# icon font
gem 'font-awesome-rails', '~> 4.6.3.0'
# Do not log asset requests in rails console
gem 'quiet_assets', '~> 1.1.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
# gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Merit as Pointsystem
gem 'merit', '~> 2.3.0'

# Markdown parser (for better formatting and display of a lecture text)
gem 'redcarpet', '~>3.3.4'
# Syntax Highlighting
gem 'codemirror-rails', '~>5.11'
gem "mini_magick"
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'
gem 'carrierwave'
#omniauth
gem 'omniauth-facebook'

#for setting the env variables
gem 'figaro'

group :development, :test do
  gem 'rspec-rails', '~> 3.4'
  gem "factory_girl_rails"
end


group :development do
  gem 'byebug'
  gem 'sqlite3'
  gem 'web-console', '~> 2.0'
  gem 'spring'
  gem 'capistrano',         require: false
  gem 'capistrano-rbenv',   require: false
  gem 'capistrano-rails',   require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano3-puma',   require: false

end

group :test do
    gem 'minitest-reporters'
    gem 'minitest'

end
