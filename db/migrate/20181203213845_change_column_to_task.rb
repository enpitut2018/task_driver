class ChangeColumnToTask < ActiveRecord::Migration[5.1]
  def change
  	change_column_default :tasks, :status, 1
  end
end
