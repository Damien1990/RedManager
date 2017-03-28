username -
- min length: 3
- max length: 16
- unique: true
- format: number, letters 
- lowercase
- presence: true

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