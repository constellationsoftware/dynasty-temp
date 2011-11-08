class ApplicationController < ActionController::Base
  #protect_from_forgery :except => [ :auth, :post_message ]
  before_filter :authenticate_user!


	  	
end
