class Customer::TransactionsController < ApplicationController
  before_action :authenticate_user!

  def new
    gateway = Braintree::Gateway.new(
    :environment=>:sandbox,
    :merchant_id=>Rails.application.credentials.dig(:braintree, :merchant_id,
    :public_key=>Rails.application.credentials.dig(:braintree, :public_key,
    :private_key=>Rails.application.credentials.dig(:braintree, :private_key
    )
    
    @client_token = gateway.client_token.generate
  end

  def create
    result = gateway.transaction.sale(
      :amount => "10.00",
      :payment_method_nonce => nonce_from_the_client,
      :device_data => device_data_from_the_client,
      :options => {
        :submit_for_settlement => true
      }
    )
  end
end
