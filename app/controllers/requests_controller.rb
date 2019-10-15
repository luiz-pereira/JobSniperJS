class RequestsController < ApplicationController

	def new
		if not logged_in?
			redirect_to '/login'
		else
			@user = current_user
			@request = Request.new
		end
	end

	def create
		@user = current_user
		@request = @user.requests.create
		params[:request][:job_titles][:job_title].split(',').each do |job_title|
			@request.job_titles.create({job_title: job_title})
		end
		params[:request][:includes][:criteria].split(',').each do |include|
			@request.includes.create({criteria: include})
		end
		params[:request][:excludes][:criteria].split(',').each do |exclude|
			@request.excludes.create({criteria: exclude})
		end
		RequestService.new.get_jobs(@request)
		redirect_to user_request_jobs_path(@user, @request)
	end

	def update
		@request = Request.find(params[:id])
	end


	def destroy
		Request.find(params[:id]).delete
		redirect_to user_path(current_user)
	end

private

	def request_params
		params.require(:request).permit(:job_title=>[:job_title])
	end

end
