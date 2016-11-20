require_relative 'route'
require 'date'
# Shipment tender data
class ShipmentTenderDatum < ApplicationRecord
  # attr_reader :type, :name, :route
  has_one :route
  belongs_to :tender

  validates_presence_of :route

  # def initialize(type, name, route)
  #   @type = type
  #   @name = name
  #   @route = route
  # end
end
