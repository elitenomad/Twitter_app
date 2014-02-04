module ApplicationHelper

	# Returns full_title of the page
	def full_title(page_title)
 		base_title = " Twitter"

 		if page_title.empty?
 			base_title
 		else
 		 	"#{base_title} | #{page_title}"
 		end		
	end

	def hash_tag_reference(content)
		if content.match(/#[a-zA-Z0-9]*/)
			#val = $&
			hashtag = Hashtag.find_by(name: "#{$&}")
			content.gsub(/#[a-zA-Z0-9]*/,"<a href='/hashtags/#{hashtag[:id]}/show'>#{$&}</a>")
		else
			content
		end
	end
end
