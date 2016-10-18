require 'route'

RSpec::Matchers.define :be_valid_route do
  match do |route|
    route.source != route.destination
  end
end

describe Route do
  context 'when routes source and destination is not the same' do
    it 'sets it correctly' do
      route_ab = described_class.new('A', 'B')
      expect(route_ab).to be_valid_route
    end
  end
  context 'when routes source and destination is the same' do
    it 'raises argument error' do
      expect { described_class.new('A', 'A') }.to raise_error(ArgumentError)
    end
  end
end
