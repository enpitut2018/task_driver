class CreateContributions < ActiveRecord::Migration[5.1]
  def change
    create_table :contributions do |t|
      t.references :user, foreign_key: true
      t.references :task, foreign_key: true
      t.datetime :finish_time
      t.boolean :is_finish?

      t.timestamps
    end
  end
end
