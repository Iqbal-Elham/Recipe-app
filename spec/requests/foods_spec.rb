require 'rails_helper'

RSpec.describe 'Foods List', type: :request do
  include Devise::Test::IntegrationHelpers

  describe 'GET /foods' do
    before(:each) do
      @user = User.create(name: 'iqbal', email: 'user@example.com', password: 'password')
      @food = Food.create(user_id: @user.id, name: 'Apple', measurement_unit: 'grams', price: 10, quantity: 1)
    end

    it 'redirects to the login page and shows notice when not authenticated' do
      get '/foods'
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(new_user_session_path)
      follow_redirect!
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('You need to sign in or sign up before continuing')
    end

    it 'shows the foods page after authentication' do
      login_as(@user)
      get '/foods'
      expect(response).to have_http_status(:ok)
      expect(request.path).to eq('/foods')
    end
  end
end
