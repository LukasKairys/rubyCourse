# Tender class
class Route
  attr_reader :source, :destination

  def initialize(source, destination)
    raise ArgumentError, 'Source and destination ' \
                          'cannot be the same' if source == destination
    @source = source
    @destination = destination
  end
end
