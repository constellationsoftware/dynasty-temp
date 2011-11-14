require 'active_record'
$config = YAML.load_file(Rails.root + 'config' + 'database.yml')

	class AbstractPlayerData < ActiveRecord::Base
		self.abstract_class = true
	    establish_connection(
	      :adapter  => "mysql2",
	      :host     => "50.16.184.114",
	      :username => "app1455111",
	      :password => "eSwWReno",
	      :database => "app1455111"
	    )
	    end
	end
end