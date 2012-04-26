class PaymentsController < ApplicationController

  helper :authorize_net
  protect_from_forgery :except => :relay_response

  # GET
  # Displays a payment form.
  def payment
    @title = 'Sign up for the 2012-2013 Season'
    @amount = 275.00
    @purchase_type = "item1<|>2012-2013 Season Membership<|>275.00<|>N"


    @sim_transaction = AuthorizeNet::SIM::Transaction.new(AUTHORIZE_NET_CONFIG['api_login_id'], AUTHORIZE_NET_CONFIG['api_transaction_key'], @amount, :relay_url => payments_relay_response_url(:only_path => false))
  end

  # POST
  # Returns relay response when Authorize.Net POSTs to us.
  def relay_response
    sim_response = AuthorizeNet::SIM::Response.new(params)
    if sim_response.success?(AUTHORIZE_NET_CONFIG['api_login_id'], AUTHORIZE_NET_CONFIG['merchant_hash_value'])
      render :text => sim_response.direct_post_reply(payments_receipt_url(:only_path => false), :include => true)
    else
      render
    end
  end


  
  # GET
  # Displays a receipt.
  def receipt
      @title = 'Your transaction has been completed.'
    @auth_code = params[:x_auth_code]
    @avs_code = params[:x_avs_code]

      @response_code = params[:x_response_code]

          @user = User.new
          @user.first_name = params[:x_first_name]
          @user.last_name = params[:x_last_name]
          @user.phone = params[:x_phone]
          @user.email = params[:x_email]
          @user.password = 'fom556'
          @user.encrypted_password = '$2a$10$N6GZ3gSlrgo/E6DahCrLB.aE6svn/./fU6kGFE7CP3EzmxI1IMh4C'
          @user.save!

          @address = UserAddress.new
          @address.user = @user
          @address.street = params[:x_address]
          @address.city = params[:x_city]
          @address.state = params[:x_state]
          @address.zip = params[:x_zip]


          @address.ship_street = params[:x_ship_to_address]
          @address.ship_city = params[:x_ship_to_city]
          @address.ship_state = params[:x_ship_to_state]
          @address.ship_zip = params[:x_ship_to_zip]


          @address.save

      end


  def purchase_dynasty_dollars
    @title = 'Purchase Dynasty Dollars'
    @user = current_user
    @team = current_user.team

    @address = @user.address
    @purchase_type = "item1<|>2012-2013 Season Membership<|>275.00<|>N"

    @sim_transaction = AuthorizeNet::SIM::Transaction.new(AUTHORIZE_NET_CONFIG['api_login_id'], AUTHORIZE_NET_CONFIG['api_transaction_key'], @amount, :relay_url => payments_relay_response_url(:only_path => false))

  end

  def dynasty_dollars_receipt
    @team = current_user.team
    @dollars_added = (params[:x_amount]).to_money
    @starting_balance = @team.balance
    @new_balance = @starting_balance + @dollars_added
    @team.balance = @new_balance
    @team.save
  end



end
