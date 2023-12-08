class AddQuantityToFoodsReciipes < ActiveRecord::Migration[7.1]
  def change
    add_column :foods_reciipes, :quantity, :integer
  end
end
