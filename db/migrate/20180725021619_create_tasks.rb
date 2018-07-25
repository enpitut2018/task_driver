class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :name
      t.datetime :deadline
      t.integer :importance
      t.text :note
      t.integer :status
      t.datetime :start_time
      t.datetime :finish_time

      t.timestamps
    end
  end
end
