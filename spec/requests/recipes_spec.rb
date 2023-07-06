require 'rails_helper'

RSpec.describe 'Recipes', type: :request do
  include Devise::Test::IntegrationHelpers
  describe 'GET /index' do
    before(:each) do
      user = User.create(name: 'iqbal', email: 'iqbal@gmail.com', password: '123456')
      login_as(user, scope: :user)
      get '/recipes'
    end
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end
end