class ClockController < ApplicationController
    respond_to :html, :json

    def show
        @clock = Clock.first
    end

    def next_week
        @clock = Clock.first
        @clock.next_week
    end

    def reset
        @clock = Clock.first
        @clock.reset
    end
end
