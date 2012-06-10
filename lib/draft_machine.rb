require 'transitions/machine'
class DraftMachine < Transitions::Machine
    def initialize(klass, name = :default)
        @klass = klass
        @name = name
        @states = []
        @state_index = {}
        @events = {}
        @auto_scopes = true

        # define states for this machine class
        state :initialized
        state :scheduled
        state :starting
        state :picking
        state :waiting
        state :finished

        event :schedule do
            transitions :from => :initialized, :to => :scheduled, :on_transition => [ :generate_picks, :charge_trophy_fee ]
        end
        event :start, :success => lambda { |d| d.delay(:run_at => Proc.new { 3.seconds.from_now }).after_start } do
            transitions :from => [ :scheduled, :starting ], :to => :starting, :on_transition => :on_start
        end
        event :pick, :success => lambda { |d| d.delay(:run_at => Proc.new { |d| d.end_of_round? ? 5.seconds.from_now : Time.now }).after_pick } do
            transitions :from => [ :starting, :waiting ], :to => :picking
        end
        event :picked, :success => lambda { |d| d.pick! } do
            transitions :from => :picking, :to => :waiting, :on_transition => :notify_picked
        end
        event :finish, :timestamp => true, :success => :after_finish do
            transitions :from => :picking, :to => :finished
        end
        event :reset, :success => :on_reset do
            transitions :from => [ :scheduled, :starting, :picking, :waiting, :finished ], :to => :scheduled
        end
        event :postpone do
            transitions :from => [ :starting, :picking, :waiting ], :to => :scheduled
        end
        event :force_finish do
            transitions :from => [ :scheduled, :starting, :picking, :waiting ], :to => :finished, :on_transition => :on_force_finish
        end
    end
end
