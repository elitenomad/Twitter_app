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

		if (content.match(/#[a-zA-Z0-9]*/) || content.match(/@[a-zA-Z0-9]*/) )
			#hashtag=[]
			#arr = content.scan(/#[a-zA-Z0-9]*/)
			# arr.each do |a|
			# 	hashtag.push( Hashtag.find_by(name: a))
			# end
			#hashtag = Hashtag.find_by(name: "#{$&}")
			if content.match(/#[a-zA-Z0-9]*|@[a-zA-Z0-9]*/)
				content.gsub(/#[a-zA-Z0-9]*|@[a-zA-Z0-9]*/) do |word|
					if word.start_with?("#")
						hashtag = Hashtag.find_by(name: word)
						word.gsub(/#[a-zA-Z0-9]*/,"<a href='/hashtags/#{hashtag[:id]}/show'>#{word}</a>")
					elsif word.start_with?("@")
						 user = User.find_by(name: word[1,word.length-1])
						 if !user.nil? 
						 	word.gsub(/@[a-zA-Z0-9]*/,"<a href='/users/#{user[:id]}'>#{word}</a>")
						 else
						 	word.gsub(/@[a-zA-Z0-9]*/,"<a href='/users'>#{word}</a>")
						 end
					end
				end
			end

			# if content.match(/@[a-zA-Z0-9]*/)
			# 	content.gsub(/@[a-zA-Z0-9]*/) do |word1|
			# 		#user = User.find_by(name: word[1,word.length-1])
			# 		#word1.gsub(/#[a-zA-Z0-9]*/,"<a href='#'>#{word1}</a>")
			# 	end
			# end
			
		else
			content
		end
	end

	def user_tag_reference(content)
		if content.match(/@[_a-zA-Z0-9]*/)
			content.gsub(/@[_a-zA-Z0-9]*/) do |word|
				user = User.find_by(name: word)
				word.gsub(/#[a-zA-Z0-9]*/,"<a href='/user/#{user[:id]}/show'>#{word}</a>")
			end
		else
			content
		end
	end
end
