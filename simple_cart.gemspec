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

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.5.2"
  s.add_dependency "haml"
  s.add_dependency "bootstrap-sass"
  s.add_dependency "sass-rails"
  s.add_dependency "wicked"
  s.add_dependency "aasm"
  s.add_dependency "jquery-rails"
  s.add_dependency "turbolinks"

  s.add_development_dependency "sqlite3"
end
