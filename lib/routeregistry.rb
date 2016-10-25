# Class holding route registry
class RouteRegistry
  @routes = { A: %w(B C), B: %w(A C), C: %w(A B) }

  class << self
    attr_reader :routes
  end
end
