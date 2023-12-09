require 'rails_helper'

RSpec.describe FoodReciipe, type: :model do
  describe 'associations' do
    it 'belongs to a reciipe' do
      association = FoodReciipe.reflect_on_association(:reciipe)
      expect(association.macro).to eq(:belongs_to)
    end

    it 'belongs to a food' do
      association = FoodReciipe.reflect_on_association(:food)
      expect(association.macro).to eq(:belongs_to)
    end
  end
end
