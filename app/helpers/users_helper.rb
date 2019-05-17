module UsersHelper

	def gravatar_for(user, size: 80)
	  	gravatar_hash = Digest::MD5::hexdigest(user.email.downcase)
	  	gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_hash}?s=#{size}"
	  	image_tag(gravatar_url)
  	end

end
