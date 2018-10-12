class CreateGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :groups do |t|
      t.integer :parent_id
      t.string :name, null: false
      t.integer :user_id, null: false
      t.integer :importance
      t.datetime :deadline

      t.timestamps
    end
  end
end
