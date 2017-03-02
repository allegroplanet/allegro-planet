class RenameGameSlugToHandle < ActiveRecord::Migration[5.0]
  def change
    rename_column :games, :slug, :handle
  end
end
