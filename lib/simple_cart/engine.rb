require 'haml'
require 'bootstrap-sass'
require 'sass-rails'
require 'wicked'
require 'aasm'

module SimpleCart
  class Engine < ::Rails::Engine
    isolate_namespace SimpleCart
  end
end
