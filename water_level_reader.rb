require 'httparty'
require 'json'
require_relative 'sensor_read'

class WaterLevelReader

  def initialize(id:, access_token:)
    @id = id
    @access_token = access_token
    @percent_var = 'WATER_LEVEL'
  end

  def fetchWaterLevelPercent
    begin
      response = HTTParty.get("https://api.particle.io/v1/devices/#{@id}/#{@percent_var}?access_token=#{@access_token}")
      body = JSON.parse(response.body)
      water_level_percent = body['result']

      return SensorRead.new(percent: current_level.to_i, success: true)
    rescue
      return SensorRead.new(success: false)
    end
  end
end
