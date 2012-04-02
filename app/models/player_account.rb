class PlayerAccount < Account
    belongs_to :payable, :class_name => 'PlayerTeamRecord', :polymorphic => true
end
