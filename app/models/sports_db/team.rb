# == Schema Information
#
# Table name: dynasty_teams
#
#  id             :integer(4)      not null, primary key
#  league_id      :integer(4)
#  name           :string(50)      not null
#  user_id        :integer(4)      not null
#  is_online      :boolean(1)      default(FALSE), not null
#  uuid           :binary(255)
#  last_socket_id :string(255)
#  balance_cents  :integer(8)      default(0), not null
#  autopick       :boolean(1)      default(FALSE)
#  waiver_order   :integer(4)
#  draft_order    :integer(4)
#

class SportsDb::Team < ActiveRecord::Base
    self.table_name = 'teams'

    has_many :american_football_action_plays
    has_one :display_name,
            :foreign_key => :entity_id,
            :conditions => { :entity_type => 'teams' }

    has_many :person_phases

    has_many :people, :through => :person_phases
    has_many :team_phases
    belongs_to :division
    belongs_to :league
    has_many :outcome_totals, :as => :outcome_holder
    has_many :affiliations, :through => :team_phases
    has_many :participants_events, :as => :participant
    has_many :stats, :as => :stat_holder
    has_many :stats, :as => :stat_membership
    belongs_to :publisher
    belongs_to :site, :foreign_key => :home_site_id
    has_and_belongs_to_many :documents, :join_table => "teams_documents"
    has_and_belongs_to_many :medias, :join_table => "teams_media"

    scope :nfl, where{ team_key =~ 'l.nfl.com%' }
    scope :current, lambda{
        sub_query = PersonPhase.select{ membership_id }
            .where{ (membership_type == 'teams') & (phase_status == 'active') & (phase_type == 'team') }
        where{ id >> sub_query }
    }

    def games_played
        games = self.participants_events
        games.each do |p|
            Event.find(p.event_id).summary
        end
    end

    def current_players
        self.person_phases.current_phase
    end

    def abbreviation
      self.display_name.abbreviation
    end

end
