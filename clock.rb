require 'clockwork'
include Clockwork

handler do |job|
  puts "Running #{job}"
end

every(60.seconds, 'seconds.job') {
  time = Time.now
  puts time
}
#every(3.minutes, 'less.frequent.job')
#every(1.hour, 'hourly.job')

#every(1.day, 'midnight.job', :at => '00:00')