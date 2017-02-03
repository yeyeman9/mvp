class Api::AudiosController < ApplicationController
  
  def index
    render :json => Audio.all.as_json(methods: :audio)
  end
  
  def show
    @audio = Audio.find(params[:id])
    render :json => @audio.as_json(methods: :audio)
  end
  
end