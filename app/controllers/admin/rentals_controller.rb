class Admin::RentalsController < BaseController 
	before_action :authenticate_user!

	def index
		@rentals = Rental.all
	end

	def show
		@rental = Rental.find(params[:id])
	end
end