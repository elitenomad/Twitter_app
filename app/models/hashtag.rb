class Hashtag < ActiveRecord::Base
	has_and_belongs_to_many :microposts

	self.per_page = 25
end
