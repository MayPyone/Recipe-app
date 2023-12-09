require 'rails_helper'

RSpec.describe 'Recipes', type: :feature do
  include Devise::Test::IntegrationHelpers
  before do
    @user = User.create!(name: 'may', email: 'khaing@gmail.com', password: '123456', id: '1')
    @recipe = Reciipe.create!(user_id: @user.id, name: 'chicken curry', description: 'First recipe')
    sign_in @user
  end

  describe 'returns recipe index page' do
    it 'returns the content of food' do
      visit reciipes_path
      expect(page).to have_content(@recipe.name)
      expect(page).to have_content(@recipe.description)
    end

    it 'returns the content of food page' do
      visit reciipes_path
      expect(page).to have_content('Remove')
      expect(page).to have_content('Recipes')
      expect(page).to have_content('New recipe')
    end
  end


  describe 'Actions for food page' do
    it 'returns action for delete' do
      visit reciipes_path
      click_button('Remove')
      sleep 15
      expect(current_path).to eq(reciipes_path)
    end

    it 'returns action for add' do
      visit reciipes_path
      within('.addrecipe-btn', wait: 15) do
        click_link('New recipe')
      end
      expect(current_path).to eq(new_reciipe_path)
    end
  end
end
