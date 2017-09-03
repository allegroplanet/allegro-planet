source 'https://rubygems.org'

ruby '2.3.1'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'carrierwave', '~> 1.0'
gem 'mini_magick', '~> 4.2.7'
gem 'carrierwave-aws'
gem 'figaro', '~> 1.1.1'
gem 'rails_admin', '~> 1.1.1'
gem 'redcarpet'
gem 'bootstrap-sass', '~> 3.2.0'
gem 'erubis'
gem 'autoprefixer-rails'
gem 'pry'
gem 'rails', '~> 5.1.3'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'sass-rails'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'bcrypt', '~> 3.1.7'
gem 'rails-controller-testing'
gem 'elasticsearch-model'

group :development, :test do
  gem 'byebug', platform: :mri
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
