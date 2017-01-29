class RemoveFieldNameFromTableName < ActiveRecord::Migration
  def change
    remove_column :audios, :audio_url
  end
  
  
end