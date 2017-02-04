class Interest < ActiveRecord::Base
  has_many :audios
  has_many :user_interests
end
