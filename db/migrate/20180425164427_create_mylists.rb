class CreateMylists < ActiveRecord::Migration[5.1]
  def change
    create_table :mylists do |t|
      t.references :user,   foreign_key: true
      t.references :list,   foreign_key: true
      t.boolean    :active, default: true
      t.boolean    :check,  default: false
      t.integer    :check_count, default: 0
      t.integer    :running_days, default: 0

      t.timestamps
    end
    add_index :mylists, [:user_id, :list_id], unique: true
  end
end
