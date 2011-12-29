require 'clockwork'
include Clockwork

handler do |job|
  puts "Running #{job}"
end

every(10.seconds, 'frequent.job')
every(3.minutes, 'less.frequent.job')
every(1.hour, 'hourly.job')

every(1.day, 'midnight.job', :at => '00:00')