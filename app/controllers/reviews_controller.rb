class ReviewsController < ApplicationController
	before_action :set_review, only: [:show, :destroy]
	before_action :set_car

	def index
		@reviews = Review.all
	end

	def show
		if @review.user_id == current_user.id
			render 'show'
		else
			redirect_to car_path(@car)
		end
	end

	def new
		@review = Review.new
	end

	def create
		@review = Review.new(review_params)
		@review.user_id = current_user.id
		@review.car_id = @car.id

		if @review.save
			redirect_to @review 
		else
			render 'new'
		end
	end

	def destroy
		@review.destroy
	end

	private
		def set_review
			@review = Review.find(params[:id])
		end

		def set_car
			@car = Car.find(parmas[:car_id])
		end

		def review_params
			params.require(:review).permit(:comment, :rating)
		end

end