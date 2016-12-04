require 'rails_helper'

RSpec.describe 'proposal/create.html.erb', type: :view do
  it 'infers the controller action' do
    expect(controller.request.path_parameters[:action]).to eq('create')
  end
end
