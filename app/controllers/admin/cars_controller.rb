class Admin::CarsController < BaseController 
	#before_action :authenticate_user!
	before_action :set_car, only: [:show, :edit, :update, :destroy]

	def index 
		@cars = Car.all
	end

	def new
		@car = Car.new
	end

	def create
		@car = current_user.cars.create(car_params)

		if @car.save
			flash[:success] = "New car added!"
			redirect_to admin_cars_path(@cars)
		else
			render :new 
		end
	end

	def show
	end

	def edit
	end

	def update
		@car.update(car_params)

		if @car.save
			redirect_to admin_car_path(@car), notice: 'Successfully updated.'
		else
			render :edit 
		end
	end

	def destroy
		@car.destroy
		redirect_to root_path
	end

	private
		def set_car
			@car = Car.find(params[:id])
		end
			
		def car_params
			params.require(:car).permit(:car_name, :category,
			 :capacity, :description, :price, :ave_rating, :available, photos: [])
		end
end