class AddIndexToAllHandles < ActiveRecord::Migration[5.0]
  def change
    add_index :users, :handle
    add_index :games, :handle
  end
end
