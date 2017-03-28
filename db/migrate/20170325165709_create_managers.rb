class CreateManagers < ActiveRecord::Migration[5.0]
  def change
    create_table :managers do |t|
      t.string :username
      t.string :email
      t.string :first_name
      t.string :last_name
      t.date :dob
      t.string :reg_ip
      t.string :last_ip
      t.boolean :online, default: false
      t.boolean :show_name, default: false
      t.timestamps
    end
  end
end
