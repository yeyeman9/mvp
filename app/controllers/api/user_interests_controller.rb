class Api::UserInterestsController < ApplicationController
  
  skip_before_filter :verify_authenticity_token   #REMOVE THIS AFTER WE HAVE AUTHENTICATION
  
  def index
    render :json => UserInterest.all
  end
  
  # POST /user_interests
  # POST /user_interests.json
  
  def create
    @user_interest = UserInterest.new(user_interest_params)

      if @user_interest.save
        render json: {
          status: 200,
          message: "Successfully added user interests",
          user_interests: @user_interest
        }.to_json
      else
        render json: {
          status: 500,
          errors: @user_interest.errors
         }.to_json
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
      params.permit(:user_id, :interest_id)
   end
  
end