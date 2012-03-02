class Ledger < ActiveRecord::Base
  def self.post(transaction)
    # transaction is a list of the form
    # description => 'tranaction id, text'
    # entries => [[amount, account],...]
    
    transaction[:entries].each { |i|
      Ledger.create( :description => transaction[:description], :amount => i[0], :account =>  i[1] )
    }
  end
  
  def self.balanced?
    sum(:amount) == 0
  end
  
  def self.account_balance(account=0)
    # account 0 is considered dynasty dollars
    Ledger.sum(:amount, :conditions=>['account=?', account] )
  end

  def self.post_payroll(amount, team, week)
    # team is team_id
    post( :description => "Payroll for team #{team}, week #{week}", :entries => [[-amount.to_i,team],[amount,0]])
  end
  
  def self.post_dynasty_dollar_transfer(amount, team_from, team_to)
    # is there league reserve on this
    post( :description => "DD transfer from team #{team_from} to #{team_to}", :entries => [[-amount.to_i,team_from],[amount,team_to]])
  end

  def self.post_dynasty_dollar_purchase(amount, team_id)
    post( :description => "DD purchase for team #{team_id}", :entries => [[amount,team_id],[-amount.to_i,0]])
  end

  def self.post_revenue_share(amount, team_id)
    # -1 is the league account
    post( :description => "Revenue share for team #{team_id}", :entries => [[amount,team_id],[-amount.to_i,-1]])
  end
  
  def self.post_new_team(amount, team_id)
    post( :description => "New team #{team_id}", :entries => [[-amount.to_i,0], [amount.to_i/2,team_id], [amount.to_i/2,-1]] )
  end
  
  def self.get_top_accounts_by_activity
    sql = "select account, count(*) from ledgers where account != 0 and account != -1 group by account order by count(*) desc limit 20"
    connection.select_all sql
  end

  def self.get_top_accounts_by_value
    sql = "select account, sum(amount) from ledgers where account != 0 and account != -1 GROUP BY account order by sum(amount) desc limit 20"
    connection.select_all sql
  end
end
