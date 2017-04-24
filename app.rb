require_relative 'water_level_reader'
require_relative 'repository'
require_relative 'notification_service'

#Particle
id = ENV['PARTICLE_ID']
access_token = ENV['PARTICLE_TOKEN']
percent_var = 'WATER_LEVEL'

#db
db_name = ENV['DB_NAME']

# Twilio
twilio_account_sid = ENV['TWILIO_ID']
twilio_auth_token = ENV['TWILIO_TOKEN']
notifier_phone = ENV['TWILIO_NOTIFIER_PHONE']
client_phone = ENV['TWILIO_RECIPIENT_PHONE']

repository = Repository.new(db_name: db_name)
reader = WaterLevelReader.new(id: id, access_token: access_token)
service = NotificationService.new(
  repository: repository,
  account_sid: twilio_account_sid,
  auth_token: twilio_auth_token,
  notifier_phone: notifier_phone,
  client_phone: client_phone)

repository.run_migrations
current_reading = reader.fetchWaterLevelPercent
service.notify_if_needed(current_reading)
