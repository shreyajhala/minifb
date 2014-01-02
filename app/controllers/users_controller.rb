class UsersController < ApplicationController

  def show
  	@user = User.find(params[:id])
    
  end  

  def follow
  	@user = User.find(params[:id])

  	if current_user

  		if current_user == @user
  			flash[:error] = "You cannot Follow yourself..!!"
  		else
  			current_user.follow(@user)
  			flash[:notice] = "You are now following #{@user.username}"
  			
  		end
  		flash[:error] = "You must login first "
   	end
   end 

   def unfollow
   		@user = User.find(params[:id])
   		if current_user
   			current_user.stop_following(@user)
   			flash[:notice] = "You are no longer Following #{@user.username}"
   		else
   			flash[:error] = "You must login first "
   		end
   end

  

end
