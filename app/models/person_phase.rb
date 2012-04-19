# == Schema Information
#
# Table name: person_phases
#
#  id                     :integer(4)      not null, primary key
#  person_id              :integer(4)      not null
#  membership_type        :string(40)      not null
#  membership_id          :integer(4)      not null
#  role_id                :integer(4)
#  role_status            :string(40)
#  phase_status           :string(40)
#  uniform_number         :string(20)
#  regular_position_id    :integer(4)
#  regular_position_depth :string(40)
#  height                 :string(100)
#  weight                 :string(100)
#  start_date_time        :datetime
#  start_season_id        :integer(4)
#  end_date_time          :datetime
#  end_season_id          :integer(4)
#  entry_reason           :string(40)
#  exit_reason            :string(40)
#  selection_level        :integer(4)
#  selection_sublevel     :integer(4)
#  selection_overall      :integer(4)
#  duration               :string(32)
#  phase_type             :string(40)
#  subphase_type          :string(40)
#

class PersonPhase < ActiveRecord::Base
    belongs_to :person


    belongs_to :membership #, :polymorphic => true

    belongs_to  :team,
                :foreign_key => 'membership_id',
                :conditions => ['membership_type = ?', 'teams'],
                :class_name => 'SportsDb::Team'

    belongs_to :affiliation,
               :foreign_key => 'membership_id',
               :conditions => ['membership_type = ?', 'affiliations']


    belongs_to :position, :class_name => 'SportsDb::Position', :foreign_key => 'regular_position_id'
    belongs_to :role
    belongs_to :start_season, :class_name => 'SportsDb::Season', :foreign_key => "end_season_id"
    belongs_to :end_season, :class_name => 'SportsDb::Season', :foreign_key => "start_season_id"


    def self.activated
        where("phase_status = ?", 'active')
    end



    def self.positioned
        where("regular_position_id IS NOT NULL")
    end

    def self.current
        where("membership_type = ?", 'teams')
    end

    def self.current_phase
        positioned.current.where("phase_status != ?", 'inactive')
    end

end
