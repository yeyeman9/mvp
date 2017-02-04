class Api::UsersController < ApplicationController

  def index
    render :json => User.all.as_json(include: :user_interests)
  end
  
  def show
    @user = User.find(params[:id])
    render :json => @user.as_json(include: :user_interests )
  end

end