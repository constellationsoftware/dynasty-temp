# == Schema Information
#
# Table name: outcome_totals
#
#  id                    :integer(4)      not null, primary key
#  standing_subgroup_id  :integer(4)      not null
#  outcome_holder_type   :string(100)
#  outcome_holder_id     :integer(4)
#  rank                  :string(100)
#  wins                  :string(100)
#  losses                :string(100)
#  ties                  :string(100)
#  wins_overtime         :integer(4)
#  losses_overtime       :integer(4)
#  undecideds            :string(100)
#  winning_percentage    :string(100)
#  points_scored_for     :string(100)
#  points_scored_against :string(100)
#  points_difference     :string(100)
#  standing_points       :string(100)
#  streak_type           :string(100)
#  streak_duration       :string(100)
#  streak_total          :string(100)
#  streak_start          :datetime
#  streak_end            :datetime
#  events_played         :integer(4)
#  games_back            :string(100)
#  result_effect         :string(100)
#  sets_against          :string(100)
#  sets_for              :string(100)
#

class OutcomeTotal < ActiveRecord::Base

    belongs_to :outcome_holder, :polymorphic => true
    belongs_to :standing_subgroup
end
