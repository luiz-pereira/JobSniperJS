class ApplicationController < ActionController::Base

	set :session_secret, "ultra-confidential"
	enable :sessions
	disable :protection
	register Sinatra::Flash

	configure do
		# set :public_folder, 'public'
		set :views, 'app/views'
	end

	get '/' do
		if logged_in?
			user = current_user
			redirect "/#{user.username}/home"
		else
			erb :home
		end
	end

	helpers do
		def current_user
			User.find_by id: session[:user_id]
		end

		def logged_in?
			!!current_user
		end

		def logout
			session.clear
		end
	end

end
