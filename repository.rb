require 'pg'
require_relative 'sensor_read'

class Repository
  def initialize(db_name:)
    @db = PG.connect(dbname: db_name)
  end

  def find_last
    @db.exec("select * from water_levels order by read_at desc limit 1") do |result|
      result.each do |row|
        values = row.values_at("id", "percent", "success", "read_at")
        return SensorRead.new(id: values[0].to_i, percent: values[1].to_i, success: values[2] == 't', read_at: DateTime.parse(values[3]))
      end
    end
    nil
  end

  def save(sensor_read)
    timestamp = DateTime.now

    percent = sensor_read.percent || 'NULL'
    @db.exec("insert into water_levels (percent, success, read_at) values (#{percent}, #{sensor_read.success}, '#{timestamp}')")
    sensor_read.read_at = timestamp
    sensor_read
  end

  def run_migrations
    # Create water_levels table
    @db.exec("CREATE TABLE IF NOT EXISTS water_levels (
    id SERIAL PRIMARY KEY,
    percent INTEGER,
    success boolean NOT NULL,
    read_at timestamp NOT NULL)")
  end
end
