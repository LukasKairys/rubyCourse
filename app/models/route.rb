require_relative 'route_registry'

# Tender class
class Route < ApplicationRecord
  validates :source_and_destination, presence: true, on: :create

  after_initialize do
    source_and_destination
  end

  def source_and_destination
    raise ArgumentError, 'Source and destination ' \
                          'cannot be the same' if source.eql?(destination)

    destinations = RouteRegistry.routes[source.to_sym]

    raise ArgumentError, 'Source not exist' unless destinations
    raise ArgumentError, 'Such path is invalid' unless destinations
                                                       .include? destination
  end

  def set_closest_next_destination
    destinations = RouteRegistry.routes[destination.to_sym]
    self.source = destination
    self.destination = destinations[0]
  end

  def ==(other)
    source.eql?(other.source) && destination.eql?(other.destination)
  end
end
