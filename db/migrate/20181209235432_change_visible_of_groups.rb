class ChangeVisibleOfGroups < ActiveRecord::Migration[5.1]
  def change
  	remove_column :groups, :visible
  	add_column :groups, :public, :boolean, default: true, null: false
  end
end
