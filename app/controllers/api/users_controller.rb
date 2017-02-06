class Api::UsersController < ApplicationController

  def index
    render :json => User.all.as_json(include: :user_interests)
  end
  
  def show
    @user = User.find(params[:id])
    
    @audio = []
    @user.user_interests.each do |i|
      # @audios =  Audio.where("interest_id = ?", i.interest_id)
      # @audio_grouped =  @audios.group_by(&:air_date)
      # @audio << @audio_grouped
      @audio << Audio.where("interest_id = ?", i.interest_id)
    end
    
   # @audio = @audio.group_by
    
    
    response = { :user => @user.as_json(include: :user_interests), :audios => @audio.as_json(methods: :audio) }
 
    render :json => response
    #render :json => @user.as_json(include: :user_interests)
    
    
    #render :json => @audio.as_json
  
  end
  
  
  def user_audios(user)
    @audio = []
    user.user_interests.each do |i|
      @audio << Audio.where("interest_id = ?", i.interest_id)
    end
  end

end