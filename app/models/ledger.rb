class Ledger < ActiveRecord::Base
  def self.post(transaction, options={})
    # transaction is a list of the form
    # description => 'tranaction id, text'
    # entries => [[amount, account],...]
    # options - useful for setting created_at or updated_at fields

    transaction[:entries].each { |i|
      Ledger.create({:description => transaction[:description], :amount => i[0], :account => i[1]}.merge options)
    }
  end
  
  # method to set BankingModel used for transactions
  # methods for money i/o and display
  # scratch ledger for projections - possibly keep these around
  # methods and theory concerning closing out ledgers
  
  def self.balanced?
    sum(:amount) == 0
  end
  
  def self.account_balance(account=0)
    # account 0 is considered dynasty dollars
    sum(:amount, :conditions => ['account = ?', account])
  end

  def self.post_payroll(amount, team, week, options={})
    # team is team_id
    post({:description => "Payroll for team #{team}, week #{week}", :entries => [[-amount.to_i,team],[amount,0]]}, options)
  end
  
  def self.post_dynasty_dollar_transfer(amount, team_from, team_to, options={})
    # is there league reserve on this
    post({:description => "DD transfer from team #{team_from} to #{team_to}", :entries => [[-amount.to_i,team_from],[amount,team_to]]}, options)
  end

  def self.post_dynasty_dollar_purchase(amount, team_id, options={})
    post({:description => "DD purchase for team #{team_id}", :entries => [[amount,team_id],[-amount.to_i,0]]}, options)
  end

  def self.post_revenue_share(amount, team_id, league_id, options={})
    # -N are league accounts
    post({:description => "Revenue share for team #{team_id}", :entries => [[amount,team_id],[-amount.to_i,-league_id.to_i]]}, options)
  end
  
  def self.post_new_team(amount, team_id, league_id, options={})
    post({:description => "New team #{team_id}", :entries => [[-amount.to_i,0], [amount.to_i/2,team_id], [amount.to_i/2,-league_id.to_i]]}, options)
  end
  
  # informational methods
  def self.get_top_accounts_by_activity
    # sql = "select account, count(*) from ledgers where account != 0 and account != -1 group by account order by count(*) desc limit 20"
    sql = "select account, count(*) from ledgers where account > 0 group by account order by count(*) desc limit 20"
    connection.select_all sql
  end

  def self.get_top_accounts_by_value
    # sql = "select account, sum(amount) from ledgers where account != 0 and account != -1 GROUP BY account order by sum(amount) desc limit 20"
    sql = "select account, sum(amount) from ledgers where account > 0 GROUP BY account order by sum(amount) desc limit 20"
    connection.select_all sql
  end
  
  def self.get_total_league_value(league_id)
    sum(:amount, :conditions => ["account = ?", -league_id.to_i])
  end

  def self.get_total_team_value
    # sum(:amount, :conditions => ['account != 0 and account != -1'])
    sum(:amount, :conditions => ['account > 0'])
  end

  def self.get_total_team_set_value(set)
    sum(:amount, :conditions => ["account in (?)", set])
  end
  
  def self.get_team_transactions(team_id)
    find_all_by_account(team_id).sort_by(&:created_at)
  end
  
  # def self.get_league_balances(set)
  #   find( :account, :amount, :conditions => ["account in (?)", set], :order => "amount desc" )
  # end
end
