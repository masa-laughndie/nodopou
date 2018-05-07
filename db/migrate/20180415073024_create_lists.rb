class CreateLists < ActiveRecord::Migration[5.1]
  def change
    create_table :lists do |t|
      t.references :user,       null:        false,
                                foreign_key: true
      t.string     :content,    null:        false
      t.integer    :user_count, null:        false,
                                default:     0

      t.timestamps
    end
  end
end
