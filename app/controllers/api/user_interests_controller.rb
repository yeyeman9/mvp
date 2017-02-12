class Api::UserInterestsController < ApplicationController
  
  skip_before_filter :verify_authenticity_token   #TODO: REMOVE THIS AFTER WE HAVE AUTHENTICATION
  
  before_filter :delete_old_interests #delete interests that aren't going to be added
  
  def index
    render :json => UserInterest.all
  end
  
  # POST /user_interests
  # POST /user_interests.json
  def create
    
    if user_interest_params
      
      @user_id = user_interest_params[:user_id]

      count = 1
      interests_to_add = does_interest_exist(user_interest_params) #only add interests that don't exist yet
    
      if interests_to_add.length >= 1 #only run this if there are interests to add
        interests_to_add.each do |interest|
          @user_interest = UserInterest.new(user_id: @user_id, interest_id: interest)
          
          if @user_interest.save
            if count == interests_to_add.length #show success only for the last one
              render json: { 
                status: 200,
                message: "Successfully added user interests",
                user_interests: @user_interest
              }.to_json
            end
          else
            render json: {
              status: 500,
              message: "Couldn't save user interests",
              errors: @user_interest.errors
            }.to_json
          end
          count += 1
        end
      else #if there are no interests to add, state so.
         render json: {
              status: 200,
              message: "No interests to add"
            }.to_json
      end
    end
  end
  
  # DELETE /user_interests/1
  # DELETE /user_interests/1.json
  def destroy
    @user_interest = UserInterest.find(params[:id])
    @user_interest.destroy
    
    if @user_interest.save
        render json: {
          status: 200,
          message: "Successfully deleted user interest",
          user_interests: @user_interest
        }.to_json
      else
        render json: {
          status: 500,
          message: "Couldn't delete user interest.",
          errors: @user_interest.errors
         }.to_json
    end
  end
  
  private 
  
   def user_interest_params
      params.permit(:user_id, :interest_id => [])
   end
   
   def does_interest_exist(user_interests)
     
     interests = []
     
     user_interests[:interest_id].each do |i|
     
      if UserInterest.where("user_id = ? AND interest_id = ?", @user_id, i).exists?
        #do nothing
      else
          interests << i   #add to interests list if interest doesn't exist
      end
     
     end
    
    interests
     
   end
   
   def delete_old_interests
    if user_interest_params
      user_id = user_interest_params[:user_id]
      new_interests = user_interest_params[:interest_id]
      interests_to_delete = []
      current_interests = []
      
      UserInterest.where("user_id = ?", user_id).each do |user_interests|
          current_interests << user_interests.interest_id.to_s
      end
      
      current_interests.each do |i|
        if new_interests.include? i
          #do nothing
        else
          interests_to_delete << i #assign interest to be deleted if it isn't part of the new interests to be added
        end
        
      end
      
      if !interests_to_delete.empty?
        interests_to_delete.each do |interest|
          an_interest = UserInterest.where("user_id = ? AND interest_id = ?", user_id, interest)
          id = an_interest.first.id
          @delete_interest = UserInterest.find(id)
          @delete_interest.destroy
          
          if @delete_interest.save
            #do nothing
          else
            render json: {
            status: 500,
            message: "Couldn't delete user interest.",
            errors: @user_interest.errors
           }.to_json
            
          end
          
        end
      end
    end
  
   end
end