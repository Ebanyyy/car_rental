class Admin::RentalsController < BaseController 
	before_action :authenticate_user!

	def index
		@rentals = Rental.all
	end

	def show
		@rental = Rental.find(params[:id])
	end

	def destroy
		Rental.destroy(params[:id])
		redirect_to admin_rentals_path
	end

end
