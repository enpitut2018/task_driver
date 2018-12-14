class RenameFinishTimeColumnInContribution < ActiveRecord::Migration[5.1]
  def change
  	rename_column :contributions, :finish_time, :finished_at
  end
end
