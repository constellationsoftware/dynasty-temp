class AbstractPlayerData < ActiveRecord::Base
	self.abstract_class = true
	establish_connection(
	  :adapter  => "mysql2",
	  :host     => "50.16.184.114",
	  :port     => 3365,
	  :username => "app1455111",
	  :password => "eSwWReno",
	  :database => "app1455111"
	)
end
