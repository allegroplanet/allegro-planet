class AddPublishedToArticle < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :published, :boolean, default: true, null: false
  end
end
