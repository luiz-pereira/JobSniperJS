class UsersController < ApplicationController

	def new
		@user = User.new
	end

	def create
		@user = User.new (user_params)
		if @user.valid?
			@user.username = @user.create_username
			@user.save
			session[:user_id] = @user.id
			redirect_to user_path(@user)
		else
			render new_user_path
		end
	end

	def show
		if session[:user_id]
			@user = User.find(session[:user_id])
			@requests = @user.requests
		else
			redirect_to root_path
		end
	end

	# APIs

	def user_requests_data
		if params[:user_id].to_i != current_user.id
			render json: {Success: false}, status: 401
		else
			@requests = current_user.requests
			render json: @requests, status: 200
		end
	end

	private

	def user_params
		params.require(:user).permit(:email, :password, :name)
	end

end
