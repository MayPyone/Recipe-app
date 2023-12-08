class Reciipe < ApplicationRecord
  belongs_to :user
  has_many :foods_reciipes, class_name: 'FoodReciipe', join_table: 'foods_reciipes'
  has_many :foods, through: :foods_reciipes
end
