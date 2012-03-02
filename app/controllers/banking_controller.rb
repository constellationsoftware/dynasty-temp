class BankingController < ApplicationController
  def stats
    @total_users = User.count
    @total_team_owners = UserTeam.count
    @total_leagues = League.count

    @total_dynasty_dollars = -Ledger.account_balance
    @total_dynasty_dollars_for_sale = UserTeam.sum(:balance_cents)
    
    @activity_list = Ledger.get_top_accounts_by_activity
    @value_list = Ledger.get_top_accounts_by_value
  end
  
  def team_stats
    @team_id = params[:id]
    @account_balance = Ledger.account_balance(params[:id])
  end
end