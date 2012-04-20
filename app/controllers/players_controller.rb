class PlayersController < ApplicationController
    before_filter :authenticate_user!
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

=begin
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
        scope.order{ points.points.desc }
    end
=end

    def index
        @team = current_user.team
        @players = apply_scopes(resource_class)
    end
end
