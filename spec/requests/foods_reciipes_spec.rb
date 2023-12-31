require 'rails_helper'

RSpec.describe 'Foods', type: :request do
  include Devise::Test::IntegrationHelpers

  before do
    @user = User.create!(name: 'may', email: 'pyone@gmail.com', password: '123456', id: '1')
    @food = Food.create!(user_id: @user.id, name: 'chicken')
    @recipe = Reciipe.create!(user_id: @user.id, name: 'chicken curry', description: 'First recipe', id: '1')
    sign_in @user
  end

  describe 'GET /index' do
    it 'returns http success' do
      get new_reciipe_foods_reciipe_path(@recipe)
      expect(response).to have_http_status(:success)
    end

    it 'render template' do
      get new_reciipe_foods_reciipe_path(@recipe)
      expect(response).to render_template(:new)
    end
  end
end
