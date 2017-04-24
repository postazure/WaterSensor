require 'twilio-ruby'
require_relative 'sensor_read'

class NotificationService
  def initialize(repository:, account_sid:, auth_token:, notifier_phone:, client_phone:)
    @repository = repository
    @account_sid = account_sid
    @auth_token = auth_token
    @notifier_phone = notifier_phone
    @client_phone = client_phone
  end

  def notify_if_needed(current_reading)
    last_reading = @repository.find_last

    if last_reading.nil?
      send_notification("Welcome. Current water level is #{current_reading.percent}")
    elsif current_reading.success == false
      if last_reading.success != false
        send_notification("Unable to get water levels!")
      end
    elsif current_reading.percent < last_reading.percent
      send_notification("Water levels is #{current_reading.percent}")
    end

    @repository.save(current_reading)
  end

  def send_notification(message)
    @client = Twilio::REST::Client.new(@account_sid, @auth_token)

    @client.account.messages.create({
      from: @notifier_phone,
      to: @client_phone,
      body: message
    })
  end
end
