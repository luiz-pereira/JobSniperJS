require_relative 'boot'

require 'rails/all'
require "google/cloud/logging"
require "google/cloud/debugger"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
Google::Cloud.configure do |config|
  config.logging.project_id = "job-sniper"
  config.logging.keyfile    = "job-sniper-rails-dbc45b78c951.json"
end


module JobSniper
	class Application < Rails::Application
		require 'open-uri'
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
