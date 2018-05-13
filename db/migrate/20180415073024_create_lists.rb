class CreateLists < ActiveRecord::Migration[5.1]
  def change
    create_table :lists do |t|
      t.integer :user_id,    null:    false
      t.string  :content,    null:    false
      t.integer :user_count, null:    false,
                             default: 0

      t.timestamps
    end
    add_index :lists, :user_id
  end
end
