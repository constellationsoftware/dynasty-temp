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
end
