class Api::InterestsController < ApplicationController
  
  def index
    render :json => Interest.all
  end
  
  def show
    render :json => Interest.find(params[:id])
  end
  
end
