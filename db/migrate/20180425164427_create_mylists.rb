class CreateMylists < ActiveRecord::Migration[5.1]
  def change
    create_table :mylists do |t|
      t.references :user,             null:        false,
                                      foreign_key: true
      t.references :list,             null:        false,
                                      foreign_key: true
      t.boolean    :active,           null:        false,
                                      default:     true
      t.boolean    :check,            null:        false,
                                      default:     false
      t.boolean    :strong,           null:        false,
                                      default:     false
      t.integer    :check_count,      null:        false,
                                      default:     0
      t.integer    :running_days,     null:        false,
                                      default:     0
      t.integer    :max_running_days, null:        false,
                                      default:     0

      t.timestamps
    end
    add_index :mylists, [:user_id, :list_id], unique: true
  end
end
