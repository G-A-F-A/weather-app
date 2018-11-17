ENV['RAILS_ENV'] ||= 'production'
require File.expand_path(File.dirname(__FILE__) + '/environment')
set :environment, ENV['RAILS_ENV']

set :output, Rails.root.join('log', 'cron_log.log')

every 1.day, at: '3:00 pm' do
  rake 'slack:send_image'
end

every 1.day, at: '9:00 pm' do
  rake 'slack:send_weather_info'
end
