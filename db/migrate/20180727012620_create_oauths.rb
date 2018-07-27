class CreateOauths < ActiveRecord::Migration[5.1]
  def change
    create_table :oauths do |t|
      t.integer :user_id
      t.string :access_token
      t.string :access_token_secret

      t.timestamps
    end
  end
end
