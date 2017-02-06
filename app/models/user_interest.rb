class UserInterest < ActiveRecord::Base
  belongs_to :users
  
  #there is a unique row of user_id to interest_id
end
