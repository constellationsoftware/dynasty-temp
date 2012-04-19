class Ability
  include CanCan::Ability

  def initialize(user)

      # Rolify user Roles: Edit the Ability model class, add these lines in the initialize method:
      # Use the resourcify method in all models you want to put a role on. For example, if we have the Forum model:
      #
      #  class Forum < ActiveRecord::Base
      #    resourcify
      # end

      if user.has_role? :guest
          can :read, :all
      end

      if user.has_role? :customer
        can :manage, User
      end

      if user.has_role? :admin
        can :manage, :all
      else
        can :manage, Team if user.has_role?(:owner, Team)
        can :manage, League, :id => League.with_role(:commissioner).map{|league| league.id}
      end
    # Define abilities for the passed in user here. For example:
    #
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
