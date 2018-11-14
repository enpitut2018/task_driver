class AddUserEndpoint < ActiveRecord::Migration[5.1]
    def change
      add_column :users, :key, :string
      add_column :users, :auth, :string
      add_column :users, :encoding, :string
    end
  end
  