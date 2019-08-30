class JobsController < ApplicationController

	def index
		redirect_to root_path if params[:user_id] != current_user.username
		@request = Request.find(params[:request_id])
		@title = @request.job_title
		@jobs = @request.jobs.order(:source, :desc)
	end

end
