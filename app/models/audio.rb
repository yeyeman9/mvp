class Audio < ActiveRecord::Base
  
  has_attached_file :audio,
                    :url => "/assets/:class/:id/:attachment/:style.:extension",
                    :path => ":rails_root/public/assets/:class/:id/:attachment/:style.:extension"
  validates_attachment_presence :audio
  validates_attachment_content_type :audio, :content_type => [ 'audio/mp3','audio/mpeg']
  
end
