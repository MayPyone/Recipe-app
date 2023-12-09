require 'rails_helper'

RSpec.describe 'Recipes', type: :feature do
  include Devise::Test::IntegrationHelpers
  before do
    @user = User.create!(name: 'may', email: 'may@gmail.com', password: '123456', id: '1')
    @recipe1 = Reciipe.create!(user_id: @user.id, name: 'chicken curry', description: 'First recipe')
    @public_recipes = [
      @recipe1
    ]
    sign_in @user
  end

  describe 'returns public recipe page' do
    it 'returns the content of Recipe' do
      visit public_reciipes_path
      expect(page).to have_content('Public Recipes')
    end
  end
end
