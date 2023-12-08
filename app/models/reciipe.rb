class Reciipe < ApplicationRecord
  belongs_to :user
  has_many :foods_reciipes
  has_many :foods, through: :foods_reciipes
end
