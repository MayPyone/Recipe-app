class Food < ApplicationRecord
  belongs_to :user
  has_many :foods_reciipes, class_name: 'FoodReciipe'
  has_many :reciipes, through: :foods_reciipes
end
