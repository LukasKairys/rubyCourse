require 'rails_helper'

RSpec.describe 'route/index.html.erb', type: :view do
  it 'displays all the routes' do
    assign(:available_routes,
           A: %w(B C), D: %w(E))

    render

    expect(rendered).to match(/A|B|C|D|E/)
  end
end
