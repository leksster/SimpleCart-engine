require 'haml'
require 'bootstrap-sass'
require 'sass-rails'
require 'wicked'
require 'aasm'
require 'jquery-rails'
require 'turbolinks'

module SimpleCart
  class Engine < ::Rails::Engine
    config.before_initialize do
      ActiveSupport.on_load :action_controller do
        helper SimpleCart::Engine.helpers
      end
    end
    
    isolate_namespace SimpleCart
  end
end
