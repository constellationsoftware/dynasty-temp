require 'redis'
require 'redis/objects'
Redis.current = Redis.new(:host => 'localhost', :port => 6379)
