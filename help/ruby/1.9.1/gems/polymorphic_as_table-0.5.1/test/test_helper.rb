DIR = File.dirname(__FILE__)
ENV['RAILS_ENV'] = 'test'
ENV['RAILS_ROOT'] ||= DIR + '/../../../..'

require 'test/unit'
require File.expand_path(File.join(ENV['RAILS_ROOT'], 'config/environment.rb'))

def load_schema
  config = YAML::load(IO.read(DIR + '/database.yml'))
  ActiveRecord::Base.logger = Logger.new(DIR + "/polymorphic_as_table_test.log")

  db_adapter = ENV['DB']

  db_adapter ||=
    begin
      require 'rubygems'
      require 'sqlite'
      'sqlite'
    rescue MissingSourceFile
      begin
        require 'sqlite3'
        'sqlite3'
      rescue MissingSourceFile
      end
    end

  if db_adapter.nil?
    rase "No DB Adapter selected. Set the DB environment variable or install sqlite or sqlite3"
  end

  ActiveRecord::Base.establish_connection(config[db_adapter])
  load(DIR + "/schema.rb")
  require DIR + '/../rails/init'
end
