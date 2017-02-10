class Api::UserInterestsController < ApplicationController
  
  skip_before_filter :verify_authenticity_token   #REMOVE THIS AFTER WE HAVE AUTHENTICATION
  
  def index
    render :json => UserInterest.all
  end
  
  # POST /user_interests
  # POST /user_interests.json
  def create
    
    if user_interest_params
      
      @user_id = user_interest_params[:user_id]
      count = 1
      user_interest_params[:interest_id].each do |interest|
       #TODO: Save all the current user's array, compare with the new arrays. Whichever are in the current interest
       # but aren't in the new interest, delete. 
       
       #TODO: Check if the interest already exists, if it doesn't create the new one
        @user_interest = UserInterest.new(user_id: @user_id, interest_id: interest)
        
        if @user_interest.save
          if count == user_interest_params[:interest_id].length #show success only for the last one
          render json: { 
              status: 200,
              message: "Successfully added user interests",
              user_interests: @user_interest
            }.to_json
          else
            
          end
        else
          render json: {
            status: 500,
            errors: @user_interest.errors
          }.to_json
        end
        
        count += 1
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
          errors: @user_interest.errors
         }.to_json
    end
  end
  
  private 
  
   def user_interest_params
      params.permit(:user_id, :interest_id => [])
   end
   
   def does_interest_exist
     
   end
  
end