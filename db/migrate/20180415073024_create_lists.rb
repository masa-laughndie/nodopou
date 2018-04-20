class CreateLists < ActiveRecord::Migration[5.1]
  def change
    create_table :lists do |t|
      t.references :user,        foreign_key: true
      t.string     :content
      t.boolean    :active,      default: true
      t.boolean    :check,       default: false
      t.integer    :check_count, default: 0

      t.timestamps
    end
  end
end
