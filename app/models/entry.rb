class Entry < ActiveRecord::Base
	has_many :conment
	belongs_to :user
	default_scope -> { order(created_at: :desc) }
	validates :user_id, presence: true
	validates :content_entry, presence: true, length: { maximum: 140 }
end
