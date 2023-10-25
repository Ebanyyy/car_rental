class ReviewsController < ApplicationController
	before_action :find_car

	def index
		@reviews = Review.all
	end

	def new
		@review = Review.new
	end

	def create
		@review = Review.new(review_params)
		@review.car_id = @car.id 
		@review.user_id = current_user.id

		if @review.save
			redirect_to car_path(@car)
		else
			render 'new'
		end
	end

	private
		def find_car
			@car = Car.find(params[:car_id])
		end

		def review_params
			params.require(:review).permit(:comment, :rating)
		end

end