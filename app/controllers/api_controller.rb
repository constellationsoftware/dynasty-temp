class ApiController < ApplicationController
  before_filter :authenticate_user!

  def post_message
  end
end
