class Admin::RentalsController < BaseController 
	before_action :authenticate_user!

	def show
		@rental = Rental.find(params[:id])
	end
end