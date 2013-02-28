class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :uuid, null: false

      t.timestamps
    end
    add_index :users, :email
    add_index :users, :uuid, unique: true
  end
end
