class User < ActiveRecord::Base
	has_many :entries
	has_many :comments
	has_many :active_relationships, class_name: "Relationship",
									foreign_key: "follower_id",
									dependent:  :destroy
	has_many :passive_relationships, class_name: "Relationship",
									foreign_key: "followed_id",
									dependent:  :destroy
	has_many :following, through: :active_relationships, source: :followed
	has_many :followers, through: :passive_relationships, source: :follower
	
	has_secure_password
	attr_accessor :remember_token
	validates :password, length: {minimum: 6, maximum: 50},
						  presence: true, if: :is_password_set?
	validates :password_confirmation, length: {minimum: 6, maximum: 50},
									  presence: true, if: :is_password_set?
	validates :email, uniqueness: true,
					  format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i},
					  length: {maximum: 32}, presence: true, if: :new_record?
	before_save { |user| user.email = email.downcase }
	before_save :create_remember_token

	def clear_remember_token
		update_attribute(:remember_digest, nil)
		# binding.pry
	end
	def authenticate?(attribute, token)
		digest = self.send("#{attribute}_digest")	
		return false if digest.nil?
		BCrypt::Password.new(digest).is_password?(token)	
	end
	
  	def is_password_set?
  		self.new_record? || !self.password.blank?
	end
	def feed
		following_ids = "SELECT followed_id FROM relationships
                     WHERE  follower_id = :user_id"
        Entry.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)
	end

	def follow other_user
		active_relationships.create(followed_id: other_user.id)
	end
	def unfollow other_user
		active_relationships.find_by(followed_id: other_user.id).destroy
	end
	def following? other_user
		following.include?(other_user)		
	end

	private
	def User.digest string
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : 
		BCrypt::Password.create(string, cost: cost)
	end

	def create_remember_token
		self.remember_token = SecureRandom.urlsafe_base64
	end

	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(remember_token))
	end
	
	def User.new_token
		SecureRandom.urlsafe_base64		
	end
end
