class ApplicationController < ActionController::Base
	#rescue_from User::NotAuthorized, :with => :user_not_authorized

  #protect_from_forgery :except => [ :auth, :post_message ]
  before_filter :authenticate_user!

  private
  	def user_not_authorized
  		render :text => 'You are not authorized for this action.', :status => 401
	  end
end
