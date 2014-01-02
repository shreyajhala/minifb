class FollowsController < ApplicationController
	def create
		@user = User.find(params[:user_id])
		current_user.follow(@user)
		respond_to do |format|
			format.js {render :action => "create"}
		end
	end

	def destroy
		@user = User.find(params[:user_id])
		current_user.stop_following(@user)
		respond_to do |format|
			format.js {render :action => "destroy"}
		end
	end

	 def show
	 	if params[:text] == "followers"
     		@user = User.find(params[:user_id])
     		@following = @user.following_users
     	else
     		@user = User.find(params[:user_id])
     		@following = @user.user_followers
     	end
   end
end
