class AlbumsController < ApplicationController
	def new
		@album = Album.new
	  1.times { @album.photos.build }
	end
 
	def create
		@album = Album.new(alb_params)	
		@album.user_id = current_user.id		
		if @album.save
			redirect_to user_album_photos_path(current_user.id, @album.id), :notice => "Album"
		else
			render :action => "new"
		end
	end
 
	def show
		if user_signed_in?

			@user = User.find(params[:user_id])
			@access_token = @user.oauth_token

			if @access_token
				@fbuser = FbGraph::User.me(@access_token)
				@fb_albums = @fbuser.albums
				
			else
				@album = Album.find(params[:id])
			end
		else
			redirect_to root_url
		end
	end

	def edit
		@album = Album.find(params[:id])
	end

	def index
		if user_signed_in?
			@user = User.find(params[:user_id])
			@album = Album.where("user_id = ? AND privacy = ?",params[:user_id], "Public")
			
			if @user == current_user
				@album = Album.where("user_id = ? ",params[:user_id])

			elsif (@user.following?(current_user)) && (current_user.followed_by?(@user))
				@album = Album.where("user_id = ? AND privacy = ? OR privacy = ?",params[:user_id], "Friends", "Public")
			end
		end
	end
	
	def update
		@album = Album.find(params[:id])
		if @album.update_attributes(alb_params)
			redirect_to user_album_photos_path(current_user.id, @album.id), :notice => "Album Updated"
		else
			render :action => "new"
		end
	end

	def destroy
		@album = Album.find(params[:id])
		@album.destroy
		redirect_to user_albums_path(current_user.id)
	end


	private
	def alb_params
		params.require(:album).permit(:name, :privacy, :photos_attributes => [:picture,:name] )
	end
end
