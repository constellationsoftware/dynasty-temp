class ClockController < InheritedResources::Base
    custom_actions :resource => [ :next_week, :reset ]
    respond_to :html, :json

    def next_week
        next_week! do |format|
            @clock.next_week
        end
    end

    def reset
        reset! do |format|
            @clock.reset
        end
    end

    protected
        def resource
            @clock = Clock.first
        end
end
