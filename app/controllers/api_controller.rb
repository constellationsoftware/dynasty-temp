class ApiController < ApplicationController
  before_filter :authenticate_user!

  def post_message
  end

  def auth
    if current_user
      #Rails.logger.info current_user.inspect
      #Rails.logger.info request.session_options[:id]
      user = current_user
      auth = Pusher[params[:channel_name]].authenticate(request.session_options[:id],
        :user_id => user.id,
        :chat_user => user.email
      )
      render :json => auth
    else
      render :text => "Not authorized", :status => '403'
    end
  end
end
