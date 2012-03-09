# ruby -Itest test/unit/ledger_test.rb
require 'test_helper'

class LedgerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'a ledger class exists' do
    assert Ledger.new != nil, "New Failed: Ledger"
  end
  
  test 'post simple transaction' do
    Ledger.post( :description => 'Simple transaction test', :entries => [[10,0],[-10,1]] )
    assert Ledger.balanced?, 'Ledger does not balance'
  end

  test 'post simple bad transaction' do
    Ledger.post( :description => 'Simple transaction test', :entries => [[10,0],[10,1]] )
    assert_equal Ledger.balanced?, false, 'Ledger balanced'
  end

  test 'post new team transaction' do
      Ledger.post_new_team( 250, 1, 1 )
    assert Ledger.balanced?, 'Ledger does not balance'
  end
  
  test 'post payroll transaction' do
    Ledger.post_payroll( 10, 1, 1 )
    assert Ledger.balanced?, 'Ledger does not balance'
  end

  test 'post revenue share transaction' do
    Ledger.post_revenue_share( 10, 1, 1 )
    assert Ledger.balanced?, 'Ledger does not balance'
  end

  test 'post dynasty dollar transaction' do
    Ledger.post_dynasty_dollar_transfer( 10, 1, 10 )
    assert Ledger.balanced?, 'Ledger does not balance'
  end

  test 'post dynasty dollar purchase' do
    Ledger.post_dynasty_dollar_purchase( 10, 1 )
    assert Ledger.balanced?, 'Ledger does not balance'
  end
  
  test 'total league value' do
    Ledger.post_new_team( 250, 1, 1 )
    Ledger.post_new_team( 250, 2, 1 )
    v = Ledger.get_total_league_value(1)
    assert_equal v, 250, "Value incorrect: #{v} == 250"
  end
  
  test 'team set values' do
    Ledger.post_new_team( 250, 1, 1 )
    Ledger.post_new_team( 200, 2, 1 )
    Ledger.post_new_team( 250, 3, 1 )
    Ledger.post_new_team( 200, 4, 1 )
    v = Ledger.get_total_team_set_value([1,3])
    assert_equal v, 250, "Value incorrect: #{v} == 250"
    v = Ledger.get_total_team_set_value([2,4])
    assert_equal v, 200, "Value incorrect: #{v} == 200"
  end
end
