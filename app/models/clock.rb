class Clock < ActiveRecord::Base
  def next_week
    self.time = self.time.to_date + 7
    self.save! 
    self.time
  end

  def reset
    self.time =  "2011-09-03 12:00:00"
    self.save!
    self.time
  end

  def present
    self.time =  Time.now
    self.save!
    self.time
  end

  def nice_time
    self.time.strftime("%B %e, %Y")
  end


end
