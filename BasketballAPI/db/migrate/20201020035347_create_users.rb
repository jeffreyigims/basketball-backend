class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :email
      t.string :firstname
      t.string :lastname
      t.date :dob
      t.string :phone

      t.timestamps
    end
  end
end
