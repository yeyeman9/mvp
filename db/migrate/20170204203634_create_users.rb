class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :f_name
      t.string :l_name
      t.string :email
      t.string :password
      t.boolean :premium
      
      t.timestamps null: false
    end
  end
end
