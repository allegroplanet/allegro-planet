class RenameUserSlugToHandle < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :slug, :handle
  end
end
