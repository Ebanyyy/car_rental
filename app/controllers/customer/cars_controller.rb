class Customer::CarsController < ApplicationController 

	def index 
		if params[:car_name]
			@cars = Car.where("car_name LIKE ? OR description LIKE ?", 
			"%#{params[:car_name]}%", "%#{params[:car_name]}%")
		else
			@cars = Car.all
		end
	end

	def show
		@cars = Car.find(params[:id])
	end
end