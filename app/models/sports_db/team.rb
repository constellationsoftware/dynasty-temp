class SportsDb::Team < ActiveRecord::Base
    self.table_name = 'teams'

    has_many :american_football_action_plays
    has_one :display_name,
            :foreign_key => 'entity_id',
            :conditions => ['entity_type = ?', 'teams']

    has_many :person_phases,
             :foreign_key => 'membership_id',
             :conditions => ['membership_type = ?', 'teams']

    has_many :people, :through => :person_phases
    has_many :team_phases
    belongs_to :division
    has_many :outcome_totals, :as => :outcome_holder
    has_many :affiliations, :through => :team_phases
    has_many :participants_events, :as => :participant
    has_many :stats, :as => :stat_holder
    has_many :stats, :as => :stat_membership
    belongs_to :publisher
    belongs_to :site, :foreign_key => :home_site_id
    has_and_belongs_to_many :documents, :join_table => "teams_documents"
    has_and_belongs_to_many :medias, :join_table => "teams_media"

    def games_played
        games = self.participants_events
        games.each do |p|
            Event.find(p.event_id).summary
        end
    end

    def name
        self.display_name.full_name
    end


end
