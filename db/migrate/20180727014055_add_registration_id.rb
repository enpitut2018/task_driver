class AddRegistrationId < ActiveRecord::Migration[5.1]
    def change
        add_column :users, :registration_id, :string
    end
end