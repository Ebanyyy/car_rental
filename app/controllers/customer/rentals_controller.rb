class Customer::RentalsController < ApplicationController 
	before_action :authenticate_user!

	def show
		@rental = Rental.find(params[:id])
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
			redirect_to car_path(@car), notice: "Booking failed"
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