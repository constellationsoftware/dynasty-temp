class LeaguesController < InheritedResources::Base
  respond_to :html, :json

  def resource
    @league ||= end_of_association_chain.find(request.subdomain)
  end
end
