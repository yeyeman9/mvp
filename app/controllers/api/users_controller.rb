class Api::UsersController < ApplicationController
  
  skip_before_filter :verify_authenticity_token  #REMOVE THIS AFTER WE HAVE AUTHENTICATION
  
  def index
    render :json => User.all.as_json(include: :user_interests)
  end
  
  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @audio_query = search_audios(@user)
    @audio = @audio_query.group_by(&:air_date)
  
    response = { :user => @user.as_json(include: :user_interests), :audios => @audio.as_json(methods: :audio) }
 
    render :json => response

  end
  
  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
      if @user.save
        render json: {
          status: 200,
          message: "Successfully created user",
          user_interests: @user
        }.to_json
      else
        render json: {
          status: 500,
          errors: @user.errors
         }.to_json
      end
  end
  
  
  private
  
    def search_audios(user)
     
      interests_array = []
     
      user.user_interests.each do |i|
        interests_array << i.interest_id 
      end
  
      audio_query = Audio.where(interest_id: interests_array)
      audio_query
    end
    
    def user_params
      params.permit(:f_name, :l_name, :email, :password, :premium)
    end

end