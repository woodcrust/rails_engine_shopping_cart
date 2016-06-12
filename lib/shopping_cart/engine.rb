require 'aasm'
require 'wicked'
require 'slim_form_object'
require 'cancancan'

module ShoppingCart
  class Engine < ::Rails::Engine
    isolate_namespace ShoppingCart

    config.generators do |g|
      g.fixture_replacement :factory_girl, dir:     'spec/factories'
      g.test_framework      :rspec,        fixture: false
      g.assets false
      g.helper false
    end

    initializer 'shopping_cart' do
      ActiveSupport.on_load(:active_record) do
        ActiveRecord::Base.extend(Settings::Product)
        ActiveRecord::Base.extend(Settings::User)
      end

      ActiveSupport.on_load(:action_controller) do
        # ActionController::Base.include(ShoppingCart::AppCtrlConcern)
        include ShoppingCart::AppCtrlConcern
        helper ShoppingCart::Engine.helpers
      end
    end
  end
end
