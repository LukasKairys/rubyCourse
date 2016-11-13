require_relative 'route'
require 'date'
# Shipment tender data
class ShipmentTenderDatum < ActiveRecord::Base
  attr_reader :type, :name, :route
  has_one :route

  def initialize(type, name, route)
    @type = type
    @name = name
    @route = route
  end
end
