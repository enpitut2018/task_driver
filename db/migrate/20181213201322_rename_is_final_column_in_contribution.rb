class RenameIsFinalColumnInContribution < ActiveRecord::Migration[5.1]
  def change
  	rename_column :contributions, :is_finish?, :finality
  end
end
