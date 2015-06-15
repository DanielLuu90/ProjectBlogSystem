module ApplicationHelper
	def full_title page_title
		base_title = "Blog System"
		page_title.blank? ? base_title : "#{base_title} #{page_title}"
	end
end
