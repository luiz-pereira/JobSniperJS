class RequestsController < ApplicationController

	skip_before_action :verify_authenticity_token

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
		params[:job_titles].split(',').each do |job_title|
			@request.job_titles.create({job_title: job_title})
		end
		params[:includes].split(',').each do |include|
			@request.includes.create({criteria: include})
		end
		params[:excludes].split(',').each do |exclude|
			@request.excludes.create({criteria: exclude})
		end
		@request.date_updated = (Time.now-9999999).strftime("%d/%m/%Y")
		@request.save
		render json: @request, status: 200
	end

	def update
		@request = Request.find(params[:id])
	end


	def destroy
		Request.find(params[:id]).delete
		render json: {success: true}, status: 200
	end

	def request_data
		@request = Request.find(params[:request_id])
		render json: @request, status: 200
	end

	# this is used for guest job search
	def temp
		@request = Request.new
		params[:job_titles].split(',').each {|title| @request.job_titles.new(job_title: title)}
		params[:includes].split(',').each {|criteria| @request.includes.new(criteria: criteria)}
		params[:excludes].split(',').each {|criteria| @request.excludes.new(criteria: criteria)}
		@request.locations = "Toronto"
		RequestService.new.get_jobs(request)
	end

private

	def request_params
		params.require(:request).permit(:job_title=>[:job_title])
	end



end
