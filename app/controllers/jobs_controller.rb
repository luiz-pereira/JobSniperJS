class JobsController < ApplicationController

	def index
		redirect_to root_path if params[:user_id].to_i != current_user.id
		@request = Request.find(params[:request_id])
		@titles = @request.job_titles
		@jobs = @request.jobs
	end

end
