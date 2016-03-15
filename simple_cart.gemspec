$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "simple_cart/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "simple_cart"
  s.version     = SimpleCart::VERSION
  s.author      = "Alex Smith"
  s.email       = ["leksster@gmail.com"]
  s.homepage    = "http://github.com/leksster"
  s.summary     = "Session shoping cart."
  s.description = "SimpleCart is a rails engine with shopping cart functionality."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "spec/factories/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 4.2", ">= 4.2.5.2"
  s.add_dependency "haml", "~> 4.0"
  s.add_dependency "bootstrap-sass", "~> 3.3"
  s.add_dependency "sass-rails", "~> 5.0"
  s.add_dependency "wicked", "~> 1.2"
  s.add_dependency "aasm", "~> 4.9"
  s.add_dependency "jquery-rails", "~> 4.1"
  s.add_dependency "turbolinks", "~> 2.5"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "byebug"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "shoulda-matchers"
  s.add_development_dependency "faker"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "capybara"
end
