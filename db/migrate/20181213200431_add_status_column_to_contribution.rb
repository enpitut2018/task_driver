class AddStatusColumnToContribution < ActiveRecord::Migration[5.1]
  def change
  	add_column :contributions, :status, :boolean, default: true, null: false
  end
end
