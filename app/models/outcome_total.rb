class OutcomeTotal < ActiveRecord::Base
  is_polymorphic_as_table
  belongs_to :outcome_holder, :polymorphic => true
  belongs_to :standing_subgroup
end
