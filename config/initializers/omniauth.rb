Rails.application.config.middleware.use OmniAuth::Builder do
	# provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
	# provider :google, ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET']
	provider :linkedin, ENV['LINKEDIN_KEY'], ENV['LINKEDIN_SECRET'], :scope => 'r_liteprofile r_emailaddress'
end