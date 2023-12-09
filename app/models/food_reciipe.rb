class FoodReciipe < ApplicationRecord
  self.table_name = 'foods_reciipes'
  belongs_to :reciipe
  belongs_to :food
end
