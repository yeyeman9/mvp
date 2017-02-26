class Api::AuthenticationController < ApplicationController
  skip_before_action :authenticate_request
  
  def authenticate
     email = params[:email]
     command = AuthenticateUser.call(params[:email], params[:password])
     
     if command.success?
       render json: { 
         user:  User.find_by_email(email),
         auth_token: command.result }
     else
       render json: { error: command.errors }, status: :unauthorized
     end
  end
end