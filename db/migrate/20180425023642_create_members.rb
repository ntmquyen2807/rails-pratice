class CreateMembers < ActiveRecord::Migration[5.1]
  def change
    create_table :members do |t|
      t.string :username
      t.string :password
      t.string :email
      t.string :img_url
      t.string :firstname
      t.string :lastname

      t.timestamps
    end
  end
end
