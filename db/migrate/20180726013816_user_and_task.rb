class UserAndTask < ActiveRecord::Migration[5.1]
  def change
    add_column :tasks, :user_id, :integer
    change_column :tasks, :user_id, :integer, null: false
  end
end
