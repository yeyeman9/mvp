module Api
  class ApiController < ApplicationController
    skip_before_filter :verify_authenticity_token  #TODO: REMOVE THIS AFTER WE HAVE AUTHENTICATION
    
  end
end
