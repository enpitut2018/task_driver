class RenameCrapColumnToTasks < ActiveRecord::Migration[5.1]
  def change
  	rename_column :tasks, :crap, :clap
  end
end
