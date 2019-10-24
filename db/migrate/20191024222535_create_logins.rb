class CreateLogins < ActiveRecord::Migration[5.2]
  def change
    create_table :logins do |t|
      t.references :user
      t.string :hash

      t.timestamps
    end
  end
end
