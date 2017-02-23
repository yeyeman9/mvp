module Api
  class ApiController < ApplicationController
    #skip_before_filter :verify_authenticity_token 
    
     # Prevent CSRF attacks by raising an exception.
      # For APIs, you may want to use :null_session instead.
      protect_from_forgery with: :null_session
      
      before_action :authenticate_request
      attr_reader :current_user
      
      private
      
      def authenticate_request
        @current_user = AuthorizeApiRequest.call(request.headers).result
        render json: { error: 'Not Authorized' }, status: 401 unless @current_user
      end
    
  end
end
