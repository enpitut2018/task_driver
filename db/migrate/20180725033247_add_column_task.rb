class AddColumnTask < ActiveRecord::Migration[5.1]
  def change
    change_column :tasks, :name, :string, null: false
    change_column :tasks, :deadline, :datetime, null: false
    change_column :tasks, :importance, :integer, null: false
    change_column :tasks, :status, :integer, null: false
  end
end
