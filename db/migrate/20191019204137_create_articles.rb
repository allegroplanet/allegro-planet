class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :handle, index: true, null: false
      t.string :title, null: false
      t.text :body_markdown, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
