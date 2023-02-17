source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.7'

gem 'rails', '~> 6.1.5'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'bcrypt', '~> 3.1.7'
gem 'image_processing', '~> 1.2'
gem 'kaminari', '~> 1.2', '>= 1.2.2'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'rack-cors', '~> 1.1', '>= 1.1.1'
gem 'jb', '~> 0.8.0'
gem 'faker', '~> 2.20'
gem "aws-sdk-s3", require: false

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'spring'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
