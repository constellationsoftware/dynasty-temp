class TestRolesController < ApplicationController
  # before_filter :authenticate_user!, :except => :user
  
  def user
    render :text => 'SUCCESS'
  end

  def admin
    check_can :admin, :all
  end

  def team_owner
    check_can :team_owner, :all
  end

  def league_founder
    check_can :league_founder, :all
  end

  def league_commissioner
    check_can :league_commissioner, :all
  end
  
  def check_can( one, two )
    if can? one, two
      render :text => 'SUCCESS'
    else
      render :text => 'FAIL'
    end
  end
end