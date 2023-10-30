class Customer::InquiriesController < ApplicationController
	before_action :find_inquiry, only: [:show, :edit, :update, :destroy]


	def index
		@inquiries = Inquiry.all.order("created_at DESC")
	end

	def show
	end

	def new
		@inquiry = Inquiry.new
	end

	def create
		@inquiry = Inquiry.new(inquiry_params)

		if @inquiry.save
			redirect_to inquiries_path
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @inquiry.update(inquiry_params)
			redirect_to customer_inquiry_params
		else
			render 'edit'
		end
	end

	def destroy
		@inquiry.destroy
		redirect_to customer_inquiries_path
	end

	private
		def inquiry_params
			params.require(:inquiry).permit(:title, :email, :message_box)
		end

		def find_inquiry
			@inquiry = Inquiry.find(params[:id])
		end
end