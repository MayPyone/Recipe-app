require 'rails_helper'

RSpec.describe 'Foods', type: :feature do
  include Devise::Test::IntegrationHelpers
  before do
    @user = User.create!(name: 'may', email: 'soe@gmail.com', password: '123456', id: '1')
    @food = Food.create!(user_id: @user.id, name: 'chicken', price: '120', quantity: '2')
    sign_in @user
  end

  describe 'returns user index page' do
    it 'returns the content of food' do
      visit root_path
      expect(page).to have_content(@food.name)
      expect(page).to have_content(@food.price)
      expect(page).to have_content(@food.quantity)
    end

    it 'returns the content of food page' do
      visit root_path
      expect(page).to have_content('Foods')
      expect(page).to have_content('Delete')
      expect(page).to have_content('Food')
      expect(page).to have_content('Measurement unit')
      expect(page).to have_content('Unit price')
      expect(page).to have_content('Actions')
      expect(page).to have_content('Add food')
    end
  end


  describe 'Actions for food page' do
    it 'returns action for delete' do
      visit root_path
      click_button('Delete')
      sleep 15
      expect(current_path).to eq(foods_path)
    end

    it 'returns action for add' do
      visit root_path
      within('.foodadd-container') do
        click_link('Add food')
      end
      expect(current_path).to eq(new_food_path)
    end
  end
end
