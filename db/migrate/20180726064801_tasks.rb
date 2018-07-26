class Tasks < ActiveRecord::Migration[5.1]
  def change
    add_reference :tasks, :user, foreign_key: true, index: false
  end
end
