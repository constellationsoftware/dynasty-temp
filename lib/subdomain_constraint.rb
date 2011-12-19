class SubdomainConstraint
  def self.matches?(request)
  	case request.subdomain
  	when !present?, 'www', '', nil
  		false
  	else
  		true
  	end
  end
end
