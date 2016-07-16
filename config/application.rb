require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module QuestApp
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.to_prepare do
        Devise::SessionsController.layout "centered_column"
        Devise::RegistrationsController.layout ->{ user_signed_in? ? "application"   : "centered_column" }
        Devise::ConfirmationsController.layout "centered_column"
        Devise::UnlocksController.layout "centered_column"
        Devise::PasswordsController.layout "centered_column"
        QuestsController.layout ->{
          default_layout = %W(index)
          centered_column = %W(new)
          case action_name
          when *default_layout
            'application'
          when *centered_column
            'centered_column'
          end
        }
        StaticPagesController.layout ->{
          default_layout = %W()
          centered_column = %W()
          temporary = %W(welcome)
          case action_name
          when *default_layout
            'application'
          when *centered_column
            'centered_column'
          when *temporary
            'temporary'
          end
        }
    end

    config.generators do |g|
      g.test_framework  :rspec, fixtures: true, views: false
      g.fixture_replacement :factory_girl, dir: "spec/factories"
    end
  end
end
