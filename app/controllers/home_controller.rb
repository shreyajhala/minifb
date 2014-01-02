class HomeController < ApplicationController
	
	def index		
		if user_signed_in?
			@user = User.search(params[:search],params[:page])
		else
		#	redirect_to register_path
			@user = User.search(params[:search],params[:page])
		end
	end

end