class Reciipe < ApplicationRecord
  has_many :foods_reciipes
  has_many :foods, through: :foods_reciipes
  has_many :ingredients, dependent: :destroy
end
