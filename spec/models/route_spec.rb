require_relative '../spec_helper'
require_relative '../../app/models/route_registry'
require_relative '../../app/models/route'

RSpec::Matchers.define :be_valid_route do
  match do |route|
    return false unless route.source != route.destination
    RouteRegistry.routes[route.source.to_sym].include? route.destination
  end
end

describe Route, type: 'model' do
  fixtures :routes
  context 'when set closest next destination is called' do
    it 'sets valid route' do
      route_ab = routes(:route_ab)
      route_ab.set_closest_next_destination
      expect(route_ab).to be_valid_route
    end
  end
  context 'when routes source and destination is the same' do
    it 'raises argument error' do
      expect { routes(:route_aa) }
        .to raise_error(ArgumentError, 'Source and destination ' \
                                        'cannot be the same')
    end
  end

  # Added after mutant
  context 'when set closest next destination is called' do
    it 'sets valid route' do
      route_ab = routes(:route_ab)
      expect(route_ab).to be_valid_route
    end
  end

  context 'when set closest next destination is called' do
    it 'moves destination to soruce and sets new destination' do
      route_ab = routes(:route_ab)
      route_ab.set_closest_next_destination
      # expect(route_ab.source).to eq('B')
      expect(route_ab.source)
        .to eq(RouteRegistry.routes[route_ab.destination.to_sym][0])
    end
  end

  context 'when source does not exist in route registry' do
    it 'raises argument error' do
      expect { routes(:route_az) }
        .to raise_error(ArgumentError, 'Such path is invalid')
    end
  end

  context 'when source does not have any destination in route registry' do
    it 'raises argument error' do
      expect { routes(:route_testa) }
        .to raise_error(ArgumentError, 'Source not exist')
    end
  end

  context 'when source is the same and destination is different' do
    it 'returns false' do
      expect(routes(:route_ab) == routes(:route_ac))
        .to be false
    end
  end

  context 'when source is different and destination is the same' do
    it 'returns false' do
      expect(routes(:route_bc) == routes(:route_ac))
        .to be false
    end
  end

  # rubocop:disable UselessComparison
  context 'when source is the same and destination is the same' do
    it 'returns true' do
      expect(routes(:route_ab) == routes(:route_ab))
        .to be true
    end
  end
end
