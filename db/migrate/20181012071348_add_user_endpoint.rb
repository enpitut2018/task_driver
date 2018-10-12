class AddUserEndpoint < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :endpoint, :string
  end
end
