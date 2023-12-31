class Customer::CheckoutsController < ApplicationController
    TRANSACTION_SUCCESS_STATUSES = [
      Braintree::Transaction::Status::Authorizing,
      Braintree::Transaction::Status::Authorized,
      Braintree::Transaction::Status::Settled,
      Braintree::Transaction::Status::SettlementConfirmed,
      Braintree::Transaction::Status::SettlementPending,
      Braintree::Transaction::Status::Settling,
      Braintree::Transaction::Status::SubmittedForSettlement,
    ]
  
    def new
      @client_token = gateway.client_token.generate
      @rental = Rental.find(params[:rental])
      @amount = @rental.total_price
    end
  
    def show
      @transaction = gateway.transaction.find(params[:id])
      @result = _create_result_hash(@transaction)
    end
  
    def create
      amount = params["amount"] # In production you should not take amounts directly from clients
      nonce = params["payment_method_nonce"]
  
      @rental = Rental.find(params[:rental_id])

      result = gateway.transaction.sale(
        amount: amount,
        payment_method_nonce: nonce,
        :options => {
          :submit_for_settlement => true
        }
      )
  
      if result.success? || result.transaction
        redirect_to customer_checkout_path(result.transaction.id)
        @rental.update(status: "success")
      else
        error_messages = result.errors.map { |error| "Error: #{error.code}: #{error.message}" }
        flash[:error] = error_messages
        redirect_to new_customer_checkout_path
      end
    end
  
    def _create_result_hash(transaction)
      status = transaction.status
  
      if TRANSACTION_SUCCESS_STATUSES.include? status
        result_hash = {
          :header => "Sweet Success!",
          :icon => "success",
          :message => "Your test transaction has been successfully processed. See the Braintree API response and try again."
        }
      else
        result_hash = {
          :header => "Transaction Failed",
          :icon => "fail",
          :message => "Your test transaction has a status of #{status}. See the Braintree API response and try again."
        }
      end
    end
  
    def gateway
  
      @gateway ||= Braintree::Gateway.new(
        :environment => :sandbox,
        :merchant_id => 'pxwg9rygz7qhrpy2',
        :public_key => '2tysx9hs82ckkvdh',
        :private_key => 'eb0507b5a40f28cea9f027e81fb66d9d',
      )
    end
  end