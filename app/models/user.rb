class User < ActiveRecord::Base
  
  acts_as_followable
  acts_as_follower

  has_attached_file :avatar, :styles => { :small => "150x150" }

  has_many :albums, :dependent => :destroy 
  

  validates :username, presence: true
  validates :location, presence: true
  validates :email, presence: true
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.location = auth.info.location
      user.email = auth.info.email
      user.username = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save(:validate => false)
    end
  end


  def self.search(search, page)

    if search
       paginate :per_page => 9, :page => page, :conditions => ['username LIKE ?', "%#{search}%"]
    else
       paginate :per_page => 9, :page => page, :conditions => ['username LIKE ?', "%#{search}%"]
    end
  end


  def to_param
    [id, username.parameterize].join("-")
  end

end
