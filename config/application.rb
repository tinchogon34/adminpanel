require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Adminpanel
  class Application < Rails::Application
    config.encoding = "utf-8" 
    config.time_zone = 'Buenos Aires'

    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    config.i18n.enforce_available_locales = true
    config.i18n.default_locale = :es

    config.assets.paths << Rails.root.join("vendor", "assets", "fonts")
    config.assets.paths << Rails.root.join("vendor", "assets", "images")


    config.i18n.fallbacks = [:en]
    
    config.generators do |g|
        g.stylesheets false
    end
  end
end
