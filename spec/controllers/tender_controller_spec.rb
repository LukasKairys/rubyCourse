require 'rails_helper'

RSpec.describe TenderController, type: :controller do
  describe 'GET #show' do
    it 'returns http success' do
      get :show
      expect(response).to have_http_status(:success)
    end
    it 'renders the new template' do
      get :show
      expect(response).to render_template('show')
    end
    it 'loads all of the tenders into @tender' do
      get :show

      expect(assigns(:tenders)).to match_array(Tender.all)
    end
  end

  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe 'POST #create' do
    it 'creates a new tender' do
      allow_any_instance_of(TenderController)
        .to receive(:read_tender_params)
        .and_return(type: 'Imp', cargo_name: 'Cargo',
                    route_from: 'A', route_to: 'B', deadline: '12.01.01')
      allow_any_instance_of(TenderController)
        .to receive(:redirect_to)
      expect { post :create }.to change { Tender.count }.by(1)
    end
    it 'redirects to the new proposal' do
      allow_any_instance_of(TenderController)
        .to receive(:read_tender_params)
        .and_return(type: 'Imp', cargo_name: 'Cargo',
                    route_from: 'A', route_to: 'B', deadline: '12.01.01')
      post :create
      expect(response).to redirect_to Tender.last
    end
  end

  context 'when accessing params' do
    it 'calls with tender params' do
      tender_controller = TenderController.new
      allow(tender_controller).to receive(:params) { { tender: [] } }
      tender_controller.read_tender_params
      expect(tender_controller).to have_received(:params)
    end
  end
end
