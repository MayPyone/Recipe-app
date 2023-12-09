# spec/models/reciipe_spec.rb

require 'rails_helper'

RSpec.describe Reciipe, type: :model do
  describe 'associations' do
    it 'belongs to a user' do
      association = Reciipe.reflect_on_association(:user)
      expect(association.macro).to eq(:belongs_to)
    end

    it 'has many foods_reciipes' do
      association = Reciipe.reflect_on_association(:foods_reciipes)
      expect(association.macro).to eq(:has_many)
    end

    it 'has many foods through foods_reciipes' do
      association = Reciipe.reflect_on_association(:foods)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:through]).to eq(:foods_reciipes)
    end
  end
end
