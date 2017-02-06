class Api::InterestsController < ApplicationController
  
  def index
    render :json => Interest.all
  end
  
  def show
    @interest = Interest.find(params[:id])
    @audios = interest_audios(@interest)
    
    response = { :interest => @interest, :audios => @audios.as_json(methods: :audio) }
    render :json => response
    
  end
  
  def interest_audios(interest)
   @audio = Audio.where("interest_id = ?", interest.id)
   @audio_grouped = @audio.group_by(&:air_date) #this groups the audios by air_date - not as useful in this "interest" model but it would be in the user model
  end
  
  
  
end
