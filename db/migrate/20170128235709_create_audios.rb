class CreateAudios < ActiveRecord::Migration
  def change
    create_table :audios do |t|
      t.integer :interest_id
      t.string :audio_url
      t.string :name
      t.text :description
      t.date :air_date
      t.integer :played_count

      t.timestamps null: false
      
      t.has_attached_file :audio
    end
  end
end
