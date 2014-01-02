class RemovephotoIdColumnToAlbum < ActiveRecord::Migration
  def change
  	remove_column :albums, :photo_id 
  end
end
