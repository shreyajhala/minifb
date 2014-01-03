class Photo < ActiveRecord::Base
	validates :picture, presence: true
	validates :name, presence: true
	belongs_to :album

	attr_reader :picture_remote_url
	has_attached_file :picture, :styles => { :small => "150x150" }

	def picture_remote_url=(url_value)
		self.picture = URI.parse(url_value)		
		@picture_remote_url = url_value
	end
end
