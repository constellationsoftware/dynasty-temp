# == Schema Information
#
# Table name: injury_phases
#
#  id              :integer(4)      not null, primary key
#  person_id       :integer(4)      not null
#  injury_status   :string(100)
#  injury_type     :string(100)
#  injury_comment  :string(100)
#  disabled_list   :string(100)
#  start_date_time :datetime
#  end_date_time   :datetime
#  season_id       :integer(4)
#  phase_type      :string(100)
#  injury_side     :string(100)
#

class InjuryPhase < ActiveRecord::Base
    # TODO: Update team rosters with status (email notifications as well? tbd)
    belongs_to :person
    belongs_to :season, :class_name => 'SportsDb::Season'
end
