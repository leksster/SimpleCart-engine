require 'rails/generators'

module SimpleCart
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    def test
      puts 'hi'
    end

    def copy_migration 
      rake 'simple_cart:install:migrations'
    end

    def init_routes
      route 'mount SimpleCart::Engine, at: "/shop"'
    end
  end
end