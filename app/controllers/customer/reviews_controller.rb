class Customer::ReviewsController < ApplicationController
	before_action :authenticate_user!
	before_action :find_car
	before_action :find_review, only: [:edit, :update, :destroy]

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
			redirect_to customer_car_path(@car)
		else
			render 'new'
		end
	end

	def edit
		
	end

	def update
		if @review.update(review_params)
			redirect_to car_path(@car)
		else
			render 'edit'
		end
	end

	def destroy
		@review.destroy
		redirect_to car_path(@car)
	end

	private
		def find_car
			@car = Car.find(params[:car_id])
		end

		def find_review
			@review = Review.find(params[:id])
		end

		def review_params
			params.require(:review).permit(:comment, :rating, :user_id)
		end

end