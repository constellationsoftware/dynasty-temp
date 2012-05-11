class Round < ActiveRecord::Base
    # is_timed

    belongs_to :draft
    has_one :league, :through => :draft

    has_many :picks
    has_many :picking_orders

#  requires :association, :draft
#  locks :association, :draft

    def current_team
        picking_orders.where(
            :position => picks.count + 1).first.team
    end
end
