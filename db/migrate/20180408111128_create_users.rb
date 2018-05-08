class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string    :name,              null:    false,
                                      limit:   50
      t.string    :email,             null:    false,
                                      limit:   255
      t.boolean   :is_send_email,     null:    false,
                                      default: false
      t.string    :account_id,        null:    false,
                                      limit:   15
      t.string    :image
      t.string    :profile
      t.string    :password_digest,   null:    false
      t.string    :remember_digest
      t.boolean   :admin,             null:    false,
                                      default: false
      t.string    :uid
      t.string    :provider
      t.string    :reset_digest
      t.string    :e_token
      t.datetime  :reset_sent_at
      t.integer   :check_reset_time,  null:    false,
                                      default: 6
      t.datetime  :check_reset_at,    null:    false,
                                      default: Time.zone.now.beginning_of_day +
                                               1.day + 6.hours

      t.timestamps
    end
    add_index :users, :account_id,    unique: true
    add_index :users, :email,         unique: true
  end
end
