class Team < ActiveRecord::Base
  has_many :american_football_action_plays
  has_one :display_name, :as => :entity
  has_many :person_phases, :as => :membership, :order => "regular_position_depth ASC, regular_position_id ASC"
  has_many :persons, :through => :person_phases
  has_many :team_phases
  belongs_to :division
  has_many :outcome_totals, :as => :outcome_holder
  has_many :affiliations, :through => :team_phases
  has_many :participants_events, :as => :participants
  has_many :stats, :as => :stat_holder
  has_many :stats, :as => :stat_membership
  belongs_to :publisher
  belongs_to :site, :foreign_key => :home_site_id
  has_and_belongs_to_many :documents, :join_table => "teams_documents"
  has_and_belongs_to_many :medias, :join_table => "teams_media"
  Team.includes(:affiliations => [:display_names])
end
