class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :entry

	validates :content, presence: true
end
