require 'route'
# ShipmentTenderData class
class ShipmentTenderData
  attr_reader :type, :name, :route, :deadline

  def initialize(type, name, route, deadline)
    @type = type
    @name = name
    @route = route
    @deadline = deadline
  end
end
