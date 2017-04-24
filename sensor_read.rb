class SensorRead
  attr_accessor :id, :read_at, :success, :percent

  def initialize(id: nil, read_at: nil, success:, percent: nil)
    @id = id
    @read_at = read_at
    @success = success
    @percent = percent
  end
end
