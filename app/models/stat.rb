class Stat < ActiveRecord::Base
  belongs_to :stat_holder, :polymorphic => true
  belongs_to :stat_coverage, :polymorphic => true
  belongs_to :stat_membership, :polymorphic => true
  belongs_to :stat_repository, :polymorphic => true
  Stat.includes(:stat_repository)
end
