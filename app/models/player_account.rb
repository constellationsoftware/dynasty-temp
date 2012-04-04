class PlayerAccount < Account
    belongs_to :payable, :class_name => 'PlayerTeam', :polymorphic => true
end
