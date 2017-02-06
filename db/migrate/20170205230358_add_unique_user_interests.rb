class AddUniqueUserInterests < ActiveRecord::Migration
  def change
    
    add_index :user_interests, [:user_id, :interest_id], :unique => true
  end
end
