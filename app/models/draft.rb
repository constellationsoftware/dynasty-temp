# == Schema Information
#
# Table name: dynasty_drafts
#
#  id              :integer(4)      not null, primary key
#  start_datetime  :datetime
#  finished_at     :datetime
#  league_id       :integer(4)      not null
#  current_pick_id :integer(2)
#  status          :string(255)
#
require 'draft_machine'
class Draft < ActiveRecord::Base
    self.table_name = 'dynasty_drafts'
    include ActiveModel::Transitions

    #self.state_machines[:default] = DraftMachine.new(self, :default)
    PRE_DRAFT_DELAY = 10 # seconds
    DELAY_BETWEEN_PICKS = 1

    belongs_to :league, :inverse_of => :draft
    has_many :teams, :primary_key => :league_id, :foreign_key => :league_id
    has_many :users, :through => :teams
    has_many :picks, :dependent => :destroy
    has_one :current_pick,
        :class_name => 'Pick',
        :conditions => 'player_id IS NOT NULL',
        :order => 'pick_order DESC'
    has_one :next_pick,
        :class_name => 'Pick',
        :conditions => { :player_id => nil },
        :order => 'pick_order'
    has_many :past_picks, :class_name => 'Pick', :conditions => 'player_id IS NOT NULL'
    has_many :future_picks, :class_name => 'Pick', :conditions => { :player_id => nil }

    attr_accessible :start_datetime
    # TODO: Flesh this validator out better sometime. We should be checking against a valid date range
    validates :start_datetime, :presence => true, :on => :save

    def all_teams_autopicking?
        self.teams.collect{ |t| t.autopicking? }.all?
    end

    def end_of_round?
        p = self.current_pick
        (!p.nil? && (p.pick_order % Settings.league.capacity) === 0)
    end

    protected
        def on_start
            # send message that draft is starting
            JuggernautPublisher.new.alert league_channels, 'draft:starting', I18n.t('activerecord.models.draft.states.starting')
        end
        def after_start; self.pick! end

        def after_pick
            return self.finish! unless self.next_pick
            do_next_pick
        end

        def do_next_pick
            p = self.next_pick
            team = p.team
            if team.online? && !(team.autopicking?)
                # patches up things with the player suggestions until we drop Pusher for good
                players = Player.available(self.league_id)
                    .recommended(team.id)
                    .includes{[ points, position ]}
                    .with_name
                    .with_contract
                    .with_favorites(team.id)
                    .order{ points.points.desc }
                    .limit(5)

                payload = Jbuilder.encode do |json|
                    json.(players) do |json, player|
                        json.id                     player.id
                        json.name do |json|
                            json.first_name         player.name.first_name
                            json.last_name          player.name.last_name
                            json.full_name          player.name.full_name
                        end
                        json.contract do |json|
                            json.amount             player.contract.amount
                            json.bye_week           player.contract.bye_week
                        end
                        json.position do |json|
                            json.abbreviation       player.position.abbreviation
                        end
                        json.points do |json|
                            json.points             player.points.points
                            json.defensive_points   player.points.defensive_points
                            json.passing_points     player.points.passing_points
                            json.rushing_points     player.points.rushing_points
                            json.sacks_against_points player.points.sacks_against_points
                            json.scoring_points     player.points.scoring_points
                            json.special_teams_points player.points.special_teams_points
                            json.games_played       player.points.games_played
                            #json.consistency        player.points.consistency
                        end
                        json.favorites do |json|
                            json.sort_order         player.favorites.first ? player.favorites.first.sort_order : nil
                        end
                    end
                end

                JuggernautPublisher.new.event team.uuid, 'draft:on-deck', payload
                JuggernautPublisher.new.event (league_channels - [team.uuid]), 'draft:picking', { :team => team.name }
            else
                # TODO: figure out a good way to batch these. Maybe at the message pushing level?
                player = Player.available(self.league_id).recommended(team.id).first
                p.player_id = player.id
            end
        end

        def notify_picked
            p = self.current_pick
            payload = {
                :player => { :id => p.player_id, :name => p.player.full_name },
                :team => { :id => p.team_id, :name => p.team.name },
                :pick => p
            }
            JuggernautPublisher.new.event league_channels, 'draft:picked', payload# unless (self.online.count === 0 or force_finish)
        end

        def after_finish
            JuggernautPublisher.new.alert league_channels, 'draft:finished', I18n.t('activerecord.models.draft.states.finished')
        end

        def on_reset
            if self.picks.update_all :player_id => nil, :picked_at => nil
                self.league.teams.each do |team|
                    team.player_teams.destroy_all
                end
            end
            JuggernautPublisher.new.alert league_channels, 'draft:reset', I18n.t('activerecord.models.draft.states.reset')
        end

        def on_postpone
            JuggernautPublisher.new.alert league_channels, 'draft:postpone', I18n.t('activerecord.models.draft.states.postponed')
        end

        def on_force_finish
            # do some stuff to force a finish
        end

        def generate_picks
            # generate picks for draft
            teams = self.league.teams.sort
            teams_reverse = teams.reverse

            Lineup.count.times do |round|
                t = round.even? ? teams : teams_reverse
                t.each_with_index do |team, i|
                    Pick.create({
                        :draft_id => self.id,
                        :team_id => team.id,
                        :pick_order => (i + 1) + (teams.size * round),
                        :round => round + 1
                    }, :without_protection => true)
                end
            end
        end

        def charge_trophy_fee
            # apply league trophy fee
            trophy_event = Events::PayTrophyFee.create!
            trophy_event.process(self.league)
        end

        # pass truthy value to exclusive to exclude the team currently picking
        def league_channels(exclusive = false)
            # gather team keys
            keys = self.teams.collect(&:uuid)
            keys -= [ current_pick.team.uuid ] if exclusive
            keys
        end
    end
