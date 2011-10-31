class ApplicationController < ActionController::Base
  protect_from_forgery :except => :auth
  before_filter :authenticate_user!
	  	
end
