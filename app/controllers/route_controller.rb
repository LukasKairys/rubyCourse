require_relative '../models/route_registry'

# Route controller for routes
class RouteController < ApplicationController
  def index
    @available_routes = RouteRegistry.routes
  end
end
