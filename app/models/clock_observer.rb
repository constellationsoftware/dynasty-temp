class ClockObserver < ActiveRecord::Observer
    observe :clock

    def after_update(record)
        Juggernaut.publish('clock-update', record.time)
    end
end
