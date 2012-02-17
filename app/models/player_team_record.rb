class PlayerTeamRecord < ActiveRecord::Base
    self.table_name = 'dynasty_player_teams'
    belongs_to :player
    belongs_to :position
    belongs_to :user_team
    belongs_to :team, :class_name => 'UserTeam', :foreign_key => :user_team_id
    has_one :user_team_lineup
    belongs_to :league

    #shortcuts (actual Person data is seldom useful)
    belongs_to :player_name,
        :class_name => 'DisplayName',
        :foreign_key => 'player_id',
        :primary_key => 'entity_id',
        :conditions => { :entity_type => 'persons' }
    belongs_to :position,
        :foreign_key => :position_id
    belongs_to :contract,
        :foreign_key => :player_id,
        :primary_key => :person_id

    attr_accessible :name, :position, :depth
    validates_with Validators::PlayerTeamRecord, :on => :update

    def name
        self.player.name.full_name
    end

    scope :has_depth, lambda{ |d| where{ depth == my{ d } } }
    scope :on_waiver_wire, where{ waiver == 1 }
    scope :starter, where{ lineup_id >= 1 }
    scope :bench, where{lineup_id == nil}


    def self.set_all_positions
        PlayerTeamRecord.all.each do |ptr|
            ptr.position_id = ptr.player.andand.position.id
            ptr.save
        end
    end

    def self.start_all
        PlayerTeamRecord.all.each do |ptr|
            ptr.depth = 1
            if ptr.valid?
                ptr.save
                ptr.update_attributes(attributes)
            end
        end
    end


    ## TODO: Make this not suck.
    def self.match_picks(draft_id)
        picks = Draft.find(draft_id).picks
        picks.each do |pick|
            ptr = PlayerTeamRecord.new
            ptr.current = TRUE
            ptr.player_id = pick.player_id
            ptr.details = "Drafted in round #{pick.round} at #{pick.picked_at} by #{pick.team.name}"
            ptr.user_team_id = pick.team_id
            ptr.league_id = UserTeam.find(pick.team_id).league.id
            ptr.added_at = pick.picked_at
            ptr.depth = 0
            ptr.position_id = Player.find(pick.player_id).position.id
            ptr.save
        end
    end

    #
    # Returns (current) records of players that share the same position
    #
    def players_in_position(position_depth = nil)
        query = self.class.where{(user_team_id == my{self.user_team_id}) & (position_id == my{self.position_id}) & (current == 1)}
        query = query.where{depth == position_depth} unless position_depth.nil?
        query
    end



    def flex_position
        @user_team = self.user_team
        @position_id = self.player.position.id
        #@players_in_position = @user_team.player_team_records.where('position_id = ?', @position_id).where('depth = ?', 1)
        #@flex_position = Position.find(@position_id).flex
        #@position = Position.find(@position_id)
        #@last_player_in_position = @players_in_position.last
        #@this_player = self.player
        #@position_abbreviation = self.position.abbreviation.upcase
        #if @position.flex == 1
        #    if @position_id == 2 && 3
        #        if @players_in_position.count > 2
        #            if @last_player_in_position == @this_player
        #                @position_abbreviation = "Flex"
        #            end
        #        end
        #    end
        #end
        #return @position_abbreviation
    end
end
