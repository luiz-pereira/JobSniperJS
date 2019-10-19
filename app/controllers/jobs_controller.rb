class JobsController < ApplicationController

	skip_before_action :verify_authenticity_token

	def index
		redirect_to root_path if params[:user_id].to_i != current_user.id
		@request = Request.find(params[:request_id])
		@user = @request.user_id
	end

	def update
		@request = Request.find(params[:request_id])
		RequestService.new.get_jobs(@request)
		render json:{body: 'sucess'}, status: 200
	end

	def jobs_data
		@request = Request.find(params[:request_id])
		@jobs = @request.jobs.order(source: :desc)
		render json: @jobs, status: 200
	end

end
