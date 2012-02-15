class League < ActiveRecord::Base
    self.table_name = 'dynasty_leagues'

    extend FriendlyId
    friendly_id :name, :use => :slugged
    money :default_balance, :cents => :default_balance_cents, :precision => 0

    #TODO: Create views, access control for users, associate league standings, schedules, and trades for user_teams
    has_many :teams, :class_name => 'UserTeam'
    has_many :users, :through => :teams
    has_many :drafts
    has_many :players, :through => :teams
    has_many :player_team_records, :through => :teams
    has_many :player_team_records
    #  requires :attribute, :name, :size
    belongs_to :manager, :class_name => 'User', :inverse_of => :leagues

    # gets the active draft (if any)
    def draft
        self.drafts.first
    end
end
