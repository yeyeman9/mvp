class UserInterest < ActiveRecord::Base
  belongs_to :users
  
  #combination of user and interest needs to be unique
end
