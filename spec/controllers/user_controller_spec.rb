# rubocop:disable all
require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #new' do
    context 'when user is not logged in' do
      it 'renders the new template' do
        get :new
        expect(response).to render_template(:new)
      end

      it 'assigns a new User to @user' do
        get :new
        expect(assigns(:user)).to be_a_new(User)
      end
    end

    context 'when user is logged in' do
      it 'redirects to customers_path for a customer' do
        user = FactoryBot.create(:user, role: :customer)
        allow(controller).to receive(:user_logged_in?).and_return(true)
        allow(controller).to receive(:current_user).and_return(user)

        get :new

        expect(response).to redirect_to(customers_path)
      end

      it 'redirects to admins_path for a hotel_admin or super_admin' do
        user = FactoryBot.create(:user, role: :hotel_admin)
        allow(controller).to receive(:user_logged_in?).and_return(true)
        allow(controller).to receive(:current_user).and_return(user)

        get :new

        expect(response).to redirect_to(admins_path)
      end
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new user' do
        user_params = FactoryBot.attributes_for(:user)
        expect do
          post :create, params: { user: user_params, role: :customer }
        end.to change(User, :count).by(1)
      end

      it 'logs in the user' do
        user_params = FactoryBot.attributes_for(:user)
        post :create, params: { user: user_params, role: :customer }
        expect(session[:user_id]).to eq(assigns(:user).id)
      end

      it 'redirects to customers_path' do
        user_params = FactoryBot.attributes_for(:user)
        post :create, params: { user: user_params, role: :customer }
        expect(response).to redirect_to(customers_path)
      end
    end

    context 'with invalid parameters' do
      it 'renders the new template' do
        post :create, params: { user: { invalid: 'parameters' }, role: :customer }
        expect(response).to render_template(:new)
      end
    end
  end
end

# rubocop:enable all