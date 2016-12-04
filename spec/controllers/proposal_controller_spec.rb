require 'rails_helper'

RSpec.describe ProposalController, type: :controller do
  fixtures :all

  let(:proposal_one) do
    proposals(:proposal_one)
  end

  describe 'GET #show' do
    it 'returns http success' do
      get :show
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      get :show
      expect(response).to render_template('show')
    end
    it 'loads all of the proposals into @proposals' do
      get :show

      expect(assigns(:proposals)).to match_array(Proposal.all)
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
    it 'creates a new proposal' do
      allow_any_instance_of(ProposalController)
        .to receive(:read_proposal_params)
        .and_return(user_id: '1', price: '100', proposals_datum_id: 1)
      allow_any_instance_of(ProposalController)
        .to receive(:redirect_to)
      expect { post :create }.to change { Proposal.count }.by(1)
    end

    it 'redirects to the new proposal' do
      allow_any_instance_of(ProposalController)
        .to receive(:read_proposal_params)
        .and_return(user_id: '1', price: '100', proposals_datum_id: 1)
      post :create
      expect(response).to redirect_to Proposal.last
    end
  end

  context 'when accessing params' do
    it 'calls with proposal params' do
      proposal_controller = ProposalController.new
      allow(proposal_controller).to receive(:params) { { tender: [] } }
      proposal_controller.read_proposal_params
      expect(proposal_controller).to have_received(:params)
    end
  end
end
