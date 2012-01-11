class PersonPhase < ActiveRecord::Base
    belongs_to :person


    belongs_to :membership #, :polymorphic => true

    belongs_to :team,
               :foreign_key => 'membership_id',
               :conditions => ['membership_type = ?', 'teams']


    belongs_to :affiliation,
               :foreign_key => 'membership_id',
               :conditions => ['membership_type = ?', 'affiliations']


    belongs_to :position, :class_name => 'SportsDb::Position', :foreign_key => 'regular_position_id'
    belongs_to :role
    belongs_to :season, :foreign_key => "end_season_id"
    belongs_to :season, :foreign_key => "start_season_id"


    def self.activated
        where("phase_status = ?", 'active')
    end

    scope :activated, activated

    def self.positioned
        where("regular_position_id IS NOT NULL")
    end

    def self.current
        where("membership_type = ?", 'teams')
    end

    def self.current_phase
        positioned.current.where("phase_status != ?", 'inactive')
    end

    scope :positioned, positioned
    scope :draftable, positioned.activated
    scope :current_phase, current_phase
end
