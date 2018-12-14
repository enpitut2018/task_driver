class SetDefaultOfFinalityInContribution < ActiveRecord::Migration[5.1]
  def change
  	change_column_default :contributions, :finality, false
  end
end
