require 'spec_helper'

RSpec.describe RouteController, type: 'controller' do
  describe 'GET #index' do
    it 'responds successfully with an HTTP 200 status code' do
      get :index
      # expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end

    it 'loads all of the registered routes into @routes' do
      get :index

      expect(assigns(:available_routes)).to match_array(RouteRegistry.routes)
    end
  end
end
