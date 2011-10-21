class OutcomeTotal < ActiveRecord::Base
  
  belongs_to :outcome_holder, :polymorphic => true
  belongs_to :standing_subgroup
end
