class UsersController < ApplicationController
	get '/signup' do
		logout
		erb :signup
	end

	post '/signup' do
		if !!User.find_by(email: params[:user][:email])
			erb :signup_failure
		else
			params[:user][:username] = get_username(params[:user][:email])
			user = User.create(params[:user])
			session[:user_id] = user.id
			redirect "/#{user.username}/home"
		end
	end

	get '/login' do
		logout
		erb :login
	end

	post '/login' do
		user = User.find_by(email: params[:user][:email])
		if user && user.authenticate(params[:user][:password])
			session[:user_id] = user.id
			redirect "/#{user.username}/home"
		else
			erb :login_failure
		end
	end

	get '/:username/home' do
		@user = current_user
		if !current_user
			redirect '/login'
		else
			@requests = @user.requests
			erb :user_home
		end
	end

	get '/logout' do
		logout
		redirect '/'
	end

	helpers do
		def get_username(email)
			email.split('@')[0]
		end
	end
end
