class Pick < ActiveRecord::Base
    self.table_name = 'dynasty_draft_picks'

    belongs_to :team
    has_one :user, :through => :team
    belongs_to :player
    belongs_to :draft, :inverse_of => :picks

    validates_exclusion_of :player_id,
        :in => lambda{ |p| p.draft.past_picks.collect{ |dp| dp.player_id } }
    validate :draft_must_be_in_picking_state, :on => :update
    validate :pick_must_be_next_for_draft, :on => :update

    attr_accessible :player_id

    protected
        def draft_must_be_in_picking_state
            unless self.draft.state === 'picking'
                errors.add(:base, I18n.t(:draft_not_ready, :scope => [ :activerecord, :errors, :models, :pick ]))
            end
        end

        def pick_must_be_next_for_draft
            unless self.draft.next_pick === self
                errors.add(:base, I18n.t(:not_next_pick, :scope => [ :activerecord, :errors, :models, :pick ]))
            end
        end
end
