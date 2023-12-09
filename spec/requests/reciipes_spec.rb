# spec/controllers/reciipes_controller_spec.rb

require 'rails_helper'

RSpec.describe ReciipesController, type: :controller do
  include Devise::Test::ControllerHelpers

  before do
    @user = User.create!(name: 'may', email: 'ma@gmail.com', password: '123456', id: '1')
    @recipe = Reciipe.create!(user_id: @user.id, name: 'chicken curry')
    sign_in @user
  end

  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    it 'renders the show template' do
      get :show, params: { id: @recipe.id }
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end
end
