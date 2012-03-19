class InjuryPhase < ActiveRecord::Base
    # TODO: Update team rosters with status (email notifications as well? tbd)
    belongs_to :person
    belongs_to :season, :class_name => 'SportsDb::Season'
end
