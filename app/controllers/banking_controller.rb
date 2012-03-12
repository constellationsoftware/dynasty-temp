class BankingController < ApplicationController
  layout 'simulator'
  require 'simulation/sim_counter'
  
  def leagues
    [(1..12),(13..24)]
  end
  
  def dynasty_stats
    @leagues = leagues
    # @total_users = User.count
    # @total_team_owners = UserTeam.count
    # @total_leagues = League.count

    @total_dynasty_dollars = -Ledger.account_balance
    @total_dynasty_dollars_for_sale = UserTeam.sum(:balance_cents)
    
    @activity_list = Ledger.get_top_accounts_by_activity
    @value_list = Ledger.get_top_accounts_by_value
    
    @total_team_value = Ledger.get_total_team_value
    @total_league_value = Ledger.get_total_league_value(-1)
    
    @week = SimCounter.count('counter')
  end
  
  def team_stats
    @team_id = params[:id]
    @account_balance = Ledger.account_balance(params[:id])
    @team_transactions = Ledger.get_team_transactions(params[:id])
    @week = SimCounter.count('counter')
  end
  
  def league_stats
    @league_id = params[:id].to_i
    @week = SimCounter.count('counter')

    @total_league_balance = Ledger.account_balance(@league_id)
    @total_team_balance = Ledger.get_total_team_set_value(leagues[@league_id-1])
    @team_set = leagues[@league_id-1]
  end
  
  # simulator methods
  def counter
    render :text => SimCounter.count('counter')
  end

  def counter_reset
    render :text => SimCounter.reset('counter')
  end

  def counter_set
    render :text => SimCounter.set('counter', params[:count])
  end

  def counter_advance
    render :text => SimCounter.advance('counter', params[:count])
  end

  def counter_retreat
    render :text => SimCounter.retreat('counter', params[:count])
  end
  
  def team_balance
    render :text => Ledger.account_balance(params[:id])
  end

  def league_balance
    render :text => Ledger.get_total_league_value(params[:id].to_i)
  end

  def team_ledger
    @team_transactions = Ledger.get_team_transactions(params[:id])
    render :template => 'banking/team_ledger', :layout => false
  end

  def activity_table
    @activity_list = Ledger.get_top_accounts_by_activity
    render :template => 'banking/activity_table', :layout => false
  end

  def balance_table
    @value_list = Ledger.get_top_accounts_by_value
    render :template => 'banking/balance_table', :layout => false
  end

  def teams_balance_table
    @team_set = leagues[params[:id].to_i-1]
    render :template => 'banking/teams_balance_table', :layout => false
  end

  def teams_balance_total
    total = 0
    @team_set = leagues[params[:id].to_i-1]
    
    @team_set.each do |i|
      total += Ledger.account_balance(i)
    end

    render :text => total
  end
  
  def total_dynasty_dollars
    render :text => -Ledger.account_balance
  end
  
  def goto_week
    Ledger.delete_all
    week = params[:week].to_i
    
    if week < 0
      week = 0
    end

    if week > 17
      week = 17
    end
    
    SimCounter.set('counter', week)
    
    (0..week).each do |i|
      file = "#{Dir.pwd}/db/simulation/week_#{i}"
      
      if File.exists? file
        load file
      end
    end
    
    render :text => 'OK'
  end
end