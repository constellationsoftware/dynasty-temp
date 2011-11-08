class DisplayName < AbstractPlayerData
  belongs_to :entity, :polymorphic => true
end
