class AddPrimaryKeyToReciipes < ActiveRecord::Migration[7.1]
  def change
    add_column :reciipes, :id, :primary_key
  end
end
