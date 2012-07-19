class DraftsController < ApplicationController
    before_filter :authenticate_user!, :set_team

    def show
        @positions = Position.select{[ id, abbreviation ]}
            .where{ abbreviation !~ '%flex%' }
            .inject({}) { |h, val| h[val['abbreviation']] = val['abbreviation'].upcase; h }
        @teams = SportsDb::Team.nfl.current.joins{ display_name }
            .select{[ id, display_name.full_name, display_name.abbreviation ]}
            .order{ display_name.full_name }
            .inject({}) { |h, val| h[val['abbreviation']] = val['full_name']; h }
        @draft = resource
    end

    # starts the draft
    def start
        draft = resource
        draft.postpone! unless draft.state == 'scheduled' || draft.state == 'starting'
        draft.start!
        render :nothing => true
    end

    def postpone
        @draft = resource
        @draft.postpone!
        render :nothing => true
    end

    def reset
        @draft = resource
        @draft.reset!
        render :nothing => true
    end

    # TODO: might want to notify and redirect users taking part in the draft IF we're ever going to use this in production.
    def finish
        @draft = resource
        @draft.force_finish!
        render :nothing => true
    end

    def autopick
        @team = current_user.team
        @team.toggle 'autopick'
        if @team.save!
            render :json => @team.autopick
        end
    end

    def send_message
        clients = JuggernautClient.find_all_by_league_id(@league.id)
        channels = clients.collect{ |client| "/observer/#{client.uuid}" }
        if channels.size > 0
            Juggernaut.publish(channels, {
                :id => nil,
                :type => :create,
                :class => 'ShoutboxMessages',
                :record => {
                    :user => @team.name,
                    :message => params[:message],
                    :timestamp => DateTime::now
                }
            })
        end
        render :nothing => true
    end

    protected
        def set_team
            @team = current_user.team
        end

        def resource
            @team.league.draft
        end
end
