class Comment < ActiveRecord::Base
	belongs_to :user, dependent: :destroy
	belongs_to :entry, dependent: :destroy

	validates :content, presence: true
end
