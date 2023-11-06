class Admin::InquiriesController < BaseController
	before_action :find_inquiry, only: [:show, :edit, :update, :destroy]

	def index
		@inquiries = Inquiry.all.order("created_at DESC")
	end

	def show
	end

	def edit
	end

	def destroy
		@inquiry.destroy
		redirect_to admin_inquiries_path
	end

	private
		def inquiry_params
			params.require(:inquiry).permit(:title, :email, :message_box)
		end

		def find_inquiry
			@inquiry = Inquiry.find(params[:id])
		end
end