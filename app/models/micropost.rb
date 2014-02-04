class Micropost < ActiveRecord::Base
	belongs_to :user
	has_and_belongs_to_many :hashtags
	default_scope -> { order('created_at DESC') }
	validates :user_id, presence: true
	validates :content, presence: true, length: {maximum: 140}

	self.per_page = 25
end
