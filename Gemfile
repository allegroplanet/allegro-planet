source 'https://rubygems.org'

ruby '2.6.5'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'graphql'
gem 'carrierwave', '~> 1.2.3'
gem 'mini_magick', '~> 4.2.10'
gem 'carrierwave-aws', '~> 1.3.0'
gem 'figaro', '~> 1.1.1'
gem 'rails_admin', '~> 1.4.2'
gem 'redcarpet', '~> 3.4.0'
gem 'erubis', '~> 2.7.0'
gem 'autoprefixer-rails', '~> 9.3.1'
gem 'pry', '~> 0.12.2'
gem 'rails', '~> 5.2.1'
gem 'pg', '~> 0.21.0'
gem 'puma', '~> 3.12.0'
gem 'sass-rails', '~> 5.0.7'
gem 'uglifier', '~> 4.1.19'
gem 'coffee-rails', '~> 4.2.2'
gem 'jquery-rails', '~> 4.3.3'
gem 'turbolinks', '~> 5.2.0'
gem 'jbuilder', '~> 2.8.0'
gem 'bcrypt', '~> 3.1.12'
gem 'rails-controller-testing', '~> 1.0.2'
gem 'elasticsearch-model', '~> 6.0.0'

group :development, :test do
  gem 'byebug', platform: :mri
end

group :development do
  gem 'web-console', '~> 3.7.0'
  gem 'listen', '~> 3.1.5'
  gem 'spring', '~> 2.0.2'
  gem 'spring-watcher-listen', '~> 2.0.1'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'graphiql-rails', group: :development