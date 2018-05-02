class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts do |t|
      t.string :name,    null:  false,
                         limit: 100
      t.string :email,   null:  false,
                         limit: 255
      t.text   :content, null:  false,
                         limit: 2000

      t.timestamps
    end
  end
end
