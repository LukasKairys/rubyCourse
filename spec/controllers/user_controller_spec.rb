require 'rails_helper'

RSpec.describe UserController, type: :controller do
  fixtures :all

  describe 'GET #show' do
    it 'returns http success' do
      get :show
      expect(response).to have_http_status(:success)
    end
    it 'renders the show template' do
      get :show
      expect(response).to render_template('show')
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
    it 'creates a new user' do
      allow_any_instance_of(UserController)
        .to receive(:read_user_params)
        .and_return(email: 'test@test.test',
                    password: 'AaaaaaA', company_name: 'Aaaaaaaa')
      allow_any_instance_of(UserController)
        .to receive(:redirect_to)
      expect { post :create }.to change { User.count }.by(1)
    end
    it 'redirects to the new proposal' do
      allow_any_instance_of(UserController)
        .to receive(:read_user_params)
        .and_return(email: 'test@test.test',
                    password: 'AaaaaaA', company_name: 'A')
      post :create
      expect(response).to redirect_to User.last
    end
  end

  context 'when creating user and company exists' do
    it 'assigns the existing company' do
      allow_any_instance_of(UserController)
        .to receive(:read_user_params)
        .and_return(email: 'test@test.test',
                    password: 'AaaaaaA', company_name: 'Aaaaaaaa')

      company_spy = class_double('Company')
                    .as_stubbed_const(transfer_nested_constants: true)
      allow(company_spy).to receive(:new).with(any_args) { true }
      allow(company_spy).to receive(:find_by) { companies(:company_one) }
      post :create

      expect(Company).not_to have_received(:new)
    end
  end

  context 'when creating user and company does not exist' do
    it 'creates and assigns new company' do
      allow_any_instance_of(UserController)
        .to receive(:read_user_params)
        .and_return(email: 'test@test.test',
                    password: 'AaaaaaA', company_name: 'TestaAAA')

      company_spy = class_double('Company')
                    .as_stubbed_const(transfer_nested_constants: true)
      allow(company_spy).to receive(:new)
        .with(any_args) { companies(:company_one) }
      allow(company_spy).to receive(:find_by) { false }
      post :create

      expect(Company).to have_received(:new)
    end
  end

  context 'when accessing params' do
    it 'calls with user params' do
      user_controller = UserController.new
      allow(user_controller).to receive(:params) { { user: [] } }
      user_controller.read_user_params
      expect(user_controller).to have_received(:params)
    end
  end
end
