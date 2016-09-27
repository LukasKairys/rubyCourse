# Tender class
class Tender
  attr_reader :type, :name, :location_to, :location_from, :deadline

  def initialize(type, name, location_from, location_to, deadline)
    @type = type
    @name = name
    @location_from = location_from
    @location_to = location_to
    @deadline = deadline
  end

  def days_to_deadline
    0
  end
end
