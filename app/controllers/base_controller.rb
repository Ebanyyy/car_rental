class BaseController < ApplicationController
	layout 'admin'
	before_action :check_if_admin

	private

	def check_if_admin
		if !current_user.is_admin?
			redirect_to root_path 
		end
	end
		
end