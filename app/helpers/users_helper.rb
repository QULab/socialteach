module UsersHelper
	def avatar_for(user, options = {size:300})
		size = options[:size]
		if user.avatar?
			image_tag user.avatar.url, width: size
		else
			image_tag "missing.png", width: size
		end
	end
end
