class DisplayName < ActiveRecord::Base
  is_polymorphic_as_table
  belongs_to :entity, :polymorphic => true
end
