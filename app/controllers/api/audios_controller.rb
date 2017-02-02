class Api::AudiosController < ApplicationController
  
  def index
    render json: Audio.all
  end
  
  def show
    @audio = Audio.find(params[:id])
    render json: @audio.audio.url
  end
  
end