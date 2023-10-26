class HomeController < ApplicationController 
	# before_action :authenticate_user!
	
	def index
		@cars = Car.all
	end
end