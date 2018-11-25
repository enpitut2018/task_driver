class AddForeignKeyToGroup < ActiveRecord::Migration[5.1]
  def change
  	add_foreign_key :groups, :users, on_update: :cascade, on_delete: :nullify
  end
end
