class MysessionsController < ApplicationController
	def create
		user = User.from_omniauth(env["omniauth.auth"])
		session[:user_id] = user.id
		sign_in user, :bypass => true
		redirect_to user_path(user)		
	end

	def destroy
		session[:user_id] = nil
		redirect_to root_url
	end
end
