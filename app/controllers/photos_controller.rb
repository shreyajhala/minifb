class PhotosController < ApplicationController

	def index
		@album = Album.find(params[:album_id])
		@photo= Photo.new
		@user = User.find(params[:user_id])
		access_token = @user.oauth_token
		@photos = Photo.where("album_id = ?",params[:album_id])	
		@albumtitle = Album.find(params[:album_id]).name
	end

	def new
		@photo= Photo.new
	end

	def destroy
		@album = Album.find(params[:album_id])
		@photo = Photo.find(params[:id])
		@photo.destroy;
		redirect_to user_album_photos_path(current_user.id,@album.id)
	end

	def show
		
	end
end