class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.references :user, null:        false,
                          foreign_key: true
      t.string :picture,  null:        false

      t.timestamps
    end
  end
end
