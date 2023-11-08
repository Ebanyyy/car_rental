class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception,
		if: Proc.new { |c| c.request.format =~ %r{application/json} }

	#before_action :authenticate_user!

	before_action :configure_permitted_parameters, if: :devise_controller?

	protected

	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up) do |user_params|
			user_params.permit(:email, :password, :password_confirmation, :admin)
		end
	end
end
