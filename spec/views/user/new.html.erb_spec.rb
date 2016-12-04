require 'rails_helper'

RSpec.describe 'user/new.html.erb', type: :view do
  it 'infers the controller action' do
    expect(controller.request.path_parameters[:action]).to eq('new')
  end
end
