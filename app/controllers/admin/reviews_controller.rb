class Admin::ReviewsController < BaseController
	def index
		@reviews = Review.all
	end
end