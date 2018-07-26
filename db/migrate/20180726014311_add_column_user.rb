class AddColumnUser < ActiveRecord::Migration[5.1]
  def change
    #t.string   :confirmation_token
    add_column :users, :confirmation_token, :string

    #t.datetime :confirmed_at
    add_column :users, :confirmed_at, :datetime

    #t.datetime :confirmation_sent_at
    add_column :users, :confirmation_sent_at, :datetime

    #t.string   :unconfirmed_email # Only if using reconfirmable
    add_column :users, :unconfirmed_email, :string

    ## Lockable
    #t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
    add_column :users, :failed_attempts, :string, default: 0, null: false

    #t.string   :unlock_token # Only if unlock strategy is :email or :both
    add_column :users, :unlock_token, :string

    #t.datetime :locked_at
    add_column :users, :locked_at, :datetime

    add_index :users, :confirmation_token,   unique: true
    add_index :users, :unlock_token,         unique: true
    
  end
end
