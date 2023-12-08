require 'rails_helper'

RSpec.describe 'Recipes', type: :feature do
  include Devise::Test::IntegrationHelpers
  before do
    @user = User.create!(name: 'may', email: 'maypyone@gmail.com', password: '123456', id: '1')
    @recipe = Reciipe.create!(user_id: @user.id, name: 'chicken curry', description: 'First recipe', id: '1')
    sign_in @user
  end

  describe 'returns recipe show page' do
    it 'returns the content of food' do
      visit reciipe_path(@recipe.id)
      expect(page).to have_content(@recipe.name)
      expect(page).to have_content(@recipe.description)
    end

    it 'returns the content of recipe page' do
      visit reciipe_path(@recipe.id)
      expect(page).to have_content('Preparation Time:')
      expect(page).to have_content('Cooking Time')
      expect(page).to have_content('Public')
      expect(page).to have_content('Destroy this recipe')
    end
  end


  describe 'Actions for recipe page' do
    it 'returns action for delete' do
      visit reciipe_path(@recipe.id)
      click_button('Destroy this recipe')
      sleep 15
      expect(current_path).to eq(reciipes_path)
    end
  end
end
