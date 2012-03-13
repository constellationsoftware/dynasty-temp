class ClockObserver < ActiveRecord::Observer
    def before_create(clock)
        clock.time ||= Settings.clock.start
    end
end
