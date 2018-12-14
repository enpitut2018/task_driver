class AddNullabilityToColumnsOfContribution < ActiveRecord::Migration[5.1]
  def change
  	change_column_null :contributions, :user_id, false
  	change_column_null :contributions, :task_id, false
  	change_column_null :contributions, :finality, false
  end
end
