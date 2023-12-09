require 'rails_helper'

RSpec.describe 'Foods', type: :request do
  include Devise::Test::IntegrationHelpers

  before do
    @user = User.create!(name: 'may', email: 'pyone@gmail.com', password: '123456', id: '1')
    @food = Food.create!(user_id: @user.id, name: 'chicken')
    sign_in @user
  end

  describe 'GET /index' do
    it 'returns http success' do
      get root_path
      expect(response).to have_http_status(:success)
    end

    it 'render template' do
      get root_path
      expect(response).to render_template(:index)
    end
  end



  describe 'GET /show' do
    it 'returns http success' do
      get foods_path(@food)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'Get #create' do
    it 'returns http success' do
      get new_food_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'DELETE #destroy' do
    it 'returns http success' do
      delete food_path(@food.id)
      expect(response).to redirect_to(foods_path)
    end
  end
end
