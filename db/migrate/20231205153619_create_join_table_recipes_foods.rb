class CreateJoinTableRecipesFoods < ActiveRecord::Migration[7.1]
  def change
    create_join_table :reciipes, :foods do |t|
      t.index [:reciipe_id, :food_id]
      t.index [:food_id, :reciipe_id]
    end
  end
end
