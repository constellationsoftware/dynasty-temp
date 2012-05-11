# == Schema Information
#
# Table name: dynasty_player_teams
#
#  id             :integer(4)      not null, primary key
#  player_id      :integer(4)
#  team_id        :integer(4)
#  current        :boolean(1)
#  added_at       :datetime
#  removed_at     :datetime
#  details        :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  position_id    :integer(4)
#  depth          :integer(4)      default(0), not null
#  waiver         :boolean(1)
#  waiver_team_id :integer(4)
#  league_id      :integer(4)
#  lineup_id      :integer(4)
#

require 'spec_helper'

describe PlayerTeam do
    let(:player_team) { build :player_team }
    let(:current_season) { Season.current }

    describe :player do
        let(:player) { player_team.player }

        describe :contract do
            before(:each) { player.contract = build :normalized_contract }
            let(:contract) { player.contract }

            context "when the player has a guaranteed contract" do
                after(:each) { contract.guaranteed.should be > 0 } # make sure we're not making silly edits

                context "when the guaranteed amount has already been paid" do
                    before {
                        contract.end_year = current_season.start_date.year + 1
                        contract.length = 2
                        contract.guaranteed = contract.amount
                    }
                    specify { player_team.guaranteed_remaining.should == 0 }
                end

                context "when the guaranteed amount will be paid halfway through the season" do
                    let(:week_mid_season) { (current_season.weeks / 2).floor }
                    let(:player_team) {
                        build :player_team_with_weekly_receipts,
                            :transaction_count => week_mid_season,
                            :transaction_start_date => current_season.start_date
                    }
                    before {
                        contract.end_year = current_season.start_date.year + 1
                        contract.length = 2
                        contract.guaranteed = contract.amount + week_mid_season
                    }
                    specify { player_team.receipts.size.should === week_mid_season }
                    specify { player_team.guaranteed_remaining.should == 0 }
                end
            end
        end
    end
end
