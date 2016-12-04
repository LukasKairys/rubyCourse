require 'rails_helper'
# Tender new view test
RSpec.describe 'tender/new.html.erb', type: :view do
  it 'infers the controller action' do
    expect(controller.request.path_parameters[:action]).to eq('new')
  end
end
