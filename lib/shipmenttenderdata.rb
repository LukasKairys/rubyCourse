require_relative 'route'
require 'date'
# ShipmentTenderData class
class ShipmentTenderData
  attr_reader :type, :name, :route

  def initialize(type, name, route)
    @type = type
    @name = name
    @route = route
  end
end
