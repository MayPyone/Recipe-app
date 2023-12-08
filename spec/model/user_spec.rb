require 'rails_helper'

RSpec.describe User, type: :model do
    before do
     @user1 = User.create!(name: 'may', email: 'maypyone@gmail.com', password: '123456')
     @user2 = User.create!(name: 'suu', email: 'suu@gmail.com', password: '123456')
    end
  describe 'User model' do
    it 'should dispaly user name' do
      expect(@user1.name).to eq('may')
      expect(@user2.name).to eq('suu')
    end

    it 'should dispaly user email' do
        expect(@user1.email).to eq('maypyone@gmail.com')
        expect(@user2.email).to eq('suu@gmail.com')
      end
    
      it 'is not valid without email' do
        @user1.email = nil
        expect(@user1).to_not be_valid
      end

      it 'is not valid using password less than 6 characters' do
        @user1.password = '1234'
        expect(@user1).to_not be_valid
      end
      
  end
end