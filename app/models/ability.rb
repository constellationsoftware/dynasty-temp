class Ability
    include CanCan::Ability

    def initialize(user)
        user ||= User.new :role => :guest # guest user (not logged in)

        if user.is? 'admin'
            can :manage, :all
            can :admin, :all
        elsif user.is? :team_owner
            can :team_owner, :all
        elsif user.is? :league_founder
            can :league_founder, :all
        elsif user.is? :league_commissioner
            can :league_commissioner, :all
        elsif user.is? :banker
            can :banker, :all
        else # :user
            can :user, :all
        end
    end
end
