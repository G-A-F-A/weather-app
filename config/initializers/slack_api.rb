require 'slack'

Slack.configure do |config|
  config.token = Rails.application.credentials.slack[:token]
end
