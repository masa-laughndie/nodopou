class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string    :name
      t.string    :email
      t.string    :account_id
      t.string    :image
      t.string    :profile
      t.string    :password_digest
      t.string    :remember_digest
      t.boolean   :admin,             default: false
      t.string    :uid
      t.string    :provider
      t.string    :reset_digest
      t.string    :e_token
      t.datetime  :reset_sent_at

      t.timestamps
    end
    add_index :users, :account_id,    unique: true
    add_index :users, :email,         unique: true
  end
end
