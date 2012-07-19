class ResearchController < ApplicationController
    respond_to :html, :json
    caches_page :index
    self.resource_class = Player

    skip_before_filter :check_registered_league
    before_filter :inject_player_params, :only => :players
    skip_before_filter :authenticate_user!

    has_scope :research, :type => :boolean, :default => true, :only => :players do |controller, scope|
        scope.joins{[ position, contract, name, points, real_team.display_name ]}
    end

    def players
        team = current_user.team
        @picked_player_ids = team.league.players.collect(&:id)
        #page = (start.zero? ? 0 : (start / length).floor) + 1
        players = apply_scopes(Player) #.paginate :page => page, :per_page => length
            .order{[ name.last_name, name.first_name ]}
        @total = players.count
        players = players.offset(params[:start]) if params.has_key? 'start'
        players = players.limit(params[:length]) if params.has_key? 'length'
        @players = players
    end

    def index

        if current_user && current_user.team && current_user.team.league
            @league = League.find(current_user.team.league_id)
            @league_players = @league.players.all

            if @league_players.include?(@player)
                @player_team = @league.player_teams.joins(:player).where(:player_id => @player.id).first
                if @player_team.team == @current_user.team
                    @message = @current_user
                else
                    @message = 1
                    @trade_team = @player_team.team

                end
            end
        else
            @message = 0
        end


        @positions = Position.select{[ id, abbreviation ]}
            .where{ abbreviation !~ '%flex%' }
            .collect{ |p| [ p['abbreviation'].upcase, p['abbreviation'] ] }
        # apply search filters
=begin
        columns = params[:sColumns].split ','
        (0...params[:iColumns].to_i).each do |i|
            value = params["sSearch_#{i}"]
            unless value === ''
                players = filter_resource players.scoped, columns[i], value
            end
        end
=end
        @teams = SportsDb::Team.nfl.current.joins{ display_name }
            .select{[ id, display_name.full_name, display_name.abbreviation ]}
            .order{ display_name.full_name }
            .collect{ |t| [ t['full_name'], t['abbreviation'] ] }
    end


    def team
    end

    def player
        @player ||= Player(params[:id])
    end


    def news
    end

    def transactions
    end

    def contracts
    end

    def depth_charts
    end

    # Hash.new{ |h,k| h[k] = Hash.new &h.default_proc }
    def factor(keypath)
        arr = keypath.split('.').map{ |v| v.to_sym }
        val ||= arr.pop
        arr.reverse.inject(val) do |rv, e|
            rv = { e => rv }
        end
    end

    protected
        def inject_player_params
            params[:research] = true
            params[:columns] =  %W(
                id
                name.first_name
                name.last_name
                position.abbreviation
                real_team.display_name.abbreviation
                contract.bye_week
                contract.amount
                contract.summary
                contract.end_year
                points.points
                points.passing_points
                points.rushing_points
                points.defensive_points
                points.fumbles_points
                points.scoring_points
                points.games_played
            ).to_json
        end
end
