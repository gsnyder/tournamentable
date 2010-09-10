# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Tournamentable::Application.initialize!


Tournamentable::Application.configure do
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    :address        => 'mailin.trb',
    :port           => 25,
    :domain         => 'mailin.trb'
  }
end