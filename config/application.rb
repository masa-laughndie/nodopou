require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Nodopou
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.i18n.default_locale = :ja
    config.load_defaults 5.1
    config.time_zone = 'Tokyo'

    config.generators do |g|
      g.stylesheets false
      g.javascripts false
    end

    config.autoload_paths += %W(#{config.root}/lib)

    config.action_view.embed_authenticity_token_in_remote_forms = true

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
