#Delayed::Worker.max_attempts = 1
=begin
Delayed::Job.destroy_failed_jobs = false
Delayed::Worker.destroy_failed_jobs = false
Delayed::Worker.sleep_delay = 60
Delayed::Worker.max_run_time = 5.minutes
Delayed::Worker.delay_jobs = !Rails.env.test?
=end
