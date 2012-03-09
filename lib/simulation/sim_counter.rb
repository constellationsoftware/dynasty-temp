# this is a simple counter class intended
# for use in the banking simulation

class SimCounter
  def self.set(file, count)
    File.open(file, 'w+', 0644) { |f|
      f.write("#{count}\n")
    }
    count
  end
  
  def self.advance(file, inc)
    count = 0
    File.open(file, 'r+', 0644) { |f|
      f.flock(File::LOCK_EX)
      count = f.read.strip.to_i + inc.to_i
      f.rewind
      f.write("#{count}\n")
      f.flush
      f.truncate(f.pos)
    }
    count
  end
  
  def self.retreat(file, dec)
    count = 0
    File.open(file, 'r+', 0644) { |f|
      f.flock(File::LOCK_EX)
      count = f.read.strip.to_i - dec.to_i
      f.rewind
      f.write("#{count}\n")
      f.flush
      f.truncate(f.pos)
    }
    count
  end
  
  def self.reset(file)
    count = 0
    File.open(file, 'w+', 0644) { |f|
      f.write(count)
    }
    count
  end
  
  def self.count(file)
    count = 0
    File.open(file) { |f|
      count = f.read.strip
    }
    count
  end
end
