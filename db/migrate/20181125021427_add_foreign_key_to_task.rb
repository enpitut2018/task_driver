class AddForeignKeyToTask < ActiveRecord::Migration[5.1]
  def change
  	add_foreign_key :tasks, :groups, on_update: :cascade, on_delete: :nullify
  end
end
