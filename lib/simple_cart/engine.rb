require 'haml'
require 'bootstrap-sass'
require 'sass-rails'

module SimpleCart
  class Engine < ::Rails::Engine
    isolate_namespace SimpleCart
  end
end
