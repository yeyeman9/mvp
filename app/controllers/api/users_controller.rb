class Api::UsersController < ApplicationController

  def index
    render :json => User.all.as_json(include: :user_interests)
  end
  
  def show
    @user = User.find(params[:id])
    @audio_query = search_audios(@user)
    @audio = @audio_query.group_by(&:air_date)
  
    response = { :user => @user.as_json(include: :user_interests), :audios => @audio.as_json(methods: :audio) }
 
    render :json => response

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
  

end