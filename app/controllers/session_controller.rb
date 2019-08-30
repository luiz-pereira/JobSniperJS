class SessionController < ApplicationController

	def new
		logout!
		@user = User.new
	end

	def create
		if auth
			# check because this is not good, I should check if it is found, not automatically create if not found.
			# The reason linkedin doesn't tell me if the user has already been accepted before
			@user = User.find_or_create_user_linkedin(auth)
		else
			if !!found_user?
				if @user.linkedin
					flash[:alert] = "User has been registered through Linkedin, please click 'sign in with Linkedin'"
				else
					unless @user.authenticate(params[:session][:password])
						flash[:alert] = "User not found. To create a new account, please 'Sign up'"
					end
				end
			else
				flash[:alert] = "User not found. To create a new account, please 'Sign up'"
				render '/session/new'
				return
			end
		end
		session[:user_id] = @user.id
		redirect_to user_path(@user)
	end

	def destroy
		session.clear
		redirect_to root_path
	end

private

	def auth
		request.env['omniauth.auth']
	end

	def found_user?
		auth ? (@user = User.find_by email: auth[:info][:email]) : (@user = User.find_by email: params[:session][:email])
	end

	def logout!
		session.clear
	end

end
