require 'routeregistry'
# Tender class
class Route
  attr_reader :source, :destination

  def initialize(source, destination)
    raise ArgumentError, 'Source and destination ' \
                          'cannot be the same' if source.eql?(destination)

    destinations = RouteRegistry.routes[source.to_sym]

    raise ArgumentError, 'Source not exist' unless destinations
    raise ArgumentError, 'Such path is invalid' unless destinations
                                                       .include? destination
    @source = source
    @destination = destination
  end

  def set_closest_next_destination
    destinations = RouteRegistry.routes[destination.to_sym]
    @source = destination
    @destination = destinations[0]
  end

  def ==(other)
    source.eql?(other.source) && destination.eql?(other.destination)
  end
end
