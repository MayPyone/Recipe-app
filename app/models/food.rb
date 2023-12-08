class Food < ApplicationRecord
  belongs_to :user
  has_many :foods_reciipes
  has_many :reciipes, through: :foods_reciipes
end
