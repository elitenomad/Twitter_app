class User < ActiveRecord::Base
	has_many :microposts, dependent: :destroy

  # http://railscasts.com/episodes/47-two-many-to-many?view=comments
  # http://guides.rubyonrails.org/association_basics.html 3.3.1 section
	has_many :relationships, foreign_key: "follower_id", dependent: :destroy
	has_many :followed_users, through: :relationships, source: :followed
  
	has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

	before_save { self.email = email.downcase }
	before_create :create_remember_token

  # follow rail casthttp://railscasts.com/episodes/274-remember-me-reset-password
  # for token functionality
	def User.new_remember_token
    	SecureRandom.urlsafe_base64
  	end

  	def User.encrypt(token)
   	 Digest::SHA1.hexdigest(token.to_s)
  	end

  	def feed
    	# This is preliminary. See "Following users" for the full implementation.
    	Micropost.where("user_id = ?", id)
      
  	end

    def all_feed
      # Changed the twitter feed from self user to all the following users
      user = User.find(id)
      Micropost.where(user_id: user.followed_user_ids)
    end

  	def following?(other_user)
    	relationships.find_by(followed_id: other_user.id)
    end

  	def follow!(other_user)
    	relationships.create!(followed_id: other_user.id)
  	end

  	def unfollow!(other_user)
    	relationships.find_by(followed_id: other_user.id).destroy
  	end

	private
	
		def create_remember_token
	   		self.remember_token = User.encrypt(User.new_remember_token)
		end

	validates :name, presence: true , length:{maximum: 50}

  # Pending regex is not working. Have to work on it.
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i   

	validates :email, presence: true,format:{with:VALID_EMAIL_REGEX},
					  uniqueness:{case_sensitive:false}

	validates :password, length: { minimum: 6 }

	self.per_page = 25

  #Episode 250 from rails casts
	has_secure_password
end
