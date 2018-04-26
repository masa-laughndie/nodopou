class CreateLists < ActiveRecord::Migration[5.1]
  def change
    create_table :lists do |t|
      t.references :user,       foreign_key: true
      t.string     :content
      t.integer    :user_count, default: 1

      t.timestamps
    end
  end
end
