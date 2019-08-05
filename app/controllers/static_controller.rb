class StaticController < ApplicationController

	def home
		if logged_in?
			redirect_to user_path(current_user)
		else
			redirect_to '/login'
		end
	end



end