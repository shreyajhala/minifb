class AddPrivacyToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :privacy, :string
  end
end
