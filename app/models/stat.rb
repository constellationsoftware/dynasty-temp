class Stat < ActiveRecord::Base
  is_polymorphic_as_table
  belongs_to :stat_holder, :polymorphic => true
  belongs_to :stat_coverage, :polymorphic => true
  belongs_to :stat_membership, :polymorphic => true
  belongs_to :stat_repository, :polymorphic => true
  Stat.includes(:stat_repository)
end
