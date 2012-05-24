require 'rss'
require 'nokogiri'
require 'open-uri'

class PlayersController < ApplicationController

    respond_to :html, :json

    has_scope :with_name
    has_scope :with_position, :type => :boolean
    has_scope :with_points, :type => :boolean
    has_scope :with_points_from_season, :default => 'current' do |controller, scope, value|
        scope.with_points_from_season(value)
    end
    has_scope :with_contract, :type => :boolean
    has_scope :available, :type => :boolean, :only => :index do |controller, scope|
        team = controller.instance_variable_get("@team")
        scope.available(team.league_id)
    end
    has_scope :with_favorites, :type => :boolean, do |controller, scope|
        team = controller.instance_variable_get("@team")
        scope.with_favorites(team.id)
    end
    has_scope :drafted, :only => :index, :type => :boolean do |controller, scope|
        team = controller.instance_variable_get("@team")
        league = team.league
        scope.drafted(league)
    end

    has_scope :roster, :only => :index, :type => :boolean do |controller, scope|
        team = controller.instance_variable_get("@team")
        scope.roster(team)
    end
    # TODO: move this to the league roster controller
    has_scope :filter_positions, :type => :boolean, :only => :index do |controller, scope, value|
        # if a filter is defined, we use that
        filter = nil
        if !!controller.params[:filter]
            filterObj = ActiveSupport::JSON.decode(controller.params[:filter])
            filter = filterObj.collect { |x|
                x['property'] === 'position' ? x['value'] : nil
            }.compact
        end
        team = controller.instance_variable_get("@team")
        scope.filter_positions(team, filter).with_name
    end
    has_scope :by_name, :allow_blank => true, :only => :index do |controller, scope, value|
        scope.with_name.by_name(value)
    end
    has_scope :ordered_by_points, :only => :index do |controller, scope|
        scope.order { points.points.desc }
    end


    def show
        player = Player.find(params[:id])
        feed_url = "http://search.nfl.com/urss?q=#{player.name.last_name}"
        open(feed_url) do |http|
            response = http.read
            @rss = RSS::Parser.parse(response, false)
        end

        @player = Player.current.with_contract.with_name.with_all_points.with_points_from_season(2011).includes(:contract, :name, :position, :points, :event_points).find(params[:id])
        #REFACTOR obviously this is shit, but my brain is fried.

        if user_signed_in?
            @league = League.find(current_user.team.league_id)
            @league_players = @league.players.all
            @open_slots = Lineup.empty(current_user.team.id).by_position(@player.position.id).all
            @closed_slots = current_user.team.player_teams.where(:lineup_id => @player.position.lineups.pluck(:id)).all

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


        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @player }
        end
    end

    def add
        @team = Team.find(session[:team_id])
        @player = Player.find(params[:player_id])
    end

    def index
        @team = current_user.team
        @players = apply_scopes(resource_class)
    end
end
