class Customer::RentalsController < ApplicationController 
	before_action :authenticate_user!

	def show
		@rental = Rental.find(params[:id])

		gateway = Braintree::Gateway.new(
		  :environment => :sandbox,
		  :merchant_id => 'pxwg9rygz7qhrpy2',
		  :public_key => '2tysx9hs82ckkvdh',
		  :private_key => 'eb0507b5a40f28cea9f027e81fb66d9d',
		)
    
  		@client_token = gateway.client_token.generate
	end

	def checkout
		gateway = Braintree::Gateway.new(
		  :environment => :sandbox,
		  :merchant_id => 'pxwg9rygz7qhrpy2',
		  :public_key => '2tysx9hs82ckkvdh',
		  :private_key => 'eb0507b5a40f28cea9f027e81fb66d9d',
		)
		 nonce_from_the_client = params[:payment_method_nonce]

		result = gateway.transaction.sale(
		  :amount => "10.00",
		  :payment_method_nonce => nonce_from_the_client,
		  :options => {
		    :submit_for_settlement => true
		  }
		)

		if result.success?
			puts "success!: #{result.transaction.id}"
		elsif result.transaction
			puts "Error processing transaction:"
			puts "	code: #{result.transaction.processor_response_code}"
			puts "	text: #{result.transaction.processor_response_text}" 
		else
			p result.errors 
		end
	end


	def new
		@car = Car.find_by(id: params[:car_id])
		@rental = Rental.new
	end

	def create
		@car = Car.find_by(id: params[:rental][:car_id])
		@rental = current_user.rentals.new(rental_params)
		@rental.car_id = @car.id 

		if available_datetime?(@rental.pick_up, @rental.drop_off, @car)
			if @rental.save
				redirect_to customer_rental_path(@rental), notice: "Booking success!"
			else
				render :new
			end
		else
			redirect_to customer_car_path(@car), notice: "Booking failed"
		end
	end

	def update
		@rental = Rental.find(params[:id])
		if params[:status] == "cancel"
			@rental.update(status: "cancel")
			redirect_back(fallback_location: root_path)
		end
	end

	private
		def rental_params
			params.require(:rental).permit(:pick_up, :drop_off, :pick_up_location, :drop_off_location, :status)
		end

		def available_datetime?(pick_up_datetime, drop_off_datetime, car)
			overlap_rentals = car.rentals.where(pick_up: pick_up_datetime..drop_off_datetime)
			.or(car.rentals.where(drop_off: pick_up_datetime..drop_off_datetime))
			overlap_rentals.empty?
		end

end