class RequestsController < ApplicationController

	def new
		if not logged_in?
			redirect_to '/login'
		else
			@user = current_user
			@request = @user.requests.create
		end
	end

	def update
		if params[:request]
			@request = Request.find(params[:request][:request_id])
		else
			@request = Request.find(params[:id])
			get_jobs(@request)
			redirect_to user_request_jobs_path(@user, @request)
			return
		end
		@user = current_user
		case params[:commit]
		when "Add 'include'"
			if valid_include?
				@request.includes.create({criteria: params[:request][:includes][:include]})
			else
				flash.now.alert = "When adding, 'include' can't be blank or existing"
			end
			render action: '/new'
		when "Add 'exclude'"
			if valid_exclude?
				@request.excludes.create({criteria: params[:request][:excludes][:exclude]})
			else
				flash.now.alert = "When adding, 'exclude' can't be blank or existing"
			end
			render action: '/new'
		when "Delete Includes"
			Include.delete_includes(params[:request][:includes][:criteria].reject(&:empty?))
			render action: '/new'
		when "Delete Excludes"
			Exclude.delete_excludes(params[:request][:excludes][:criteria].reject(&:empty?))
			render action: '/new'
		else
			if valid_parameters?
				save_job_titles
				get_jobs(@request)
				redirect_to user_request_jobs_path(@user, @request)
			else
				flash.now.alert = "Please include at least one critera ('include' or 'exclude')"
				render action: '/new'
			end
		end
	end

	def destroy
		Request.find(params[:id]).delete
		redirect_to user_path(current_user)
	end


	def get_jobs(request)
		@user = current_user
		@request = request
		binding.pry
		@title = @request.job_title || ''
		@include = @request.includes.map(&:criteria)
		@exclude = @request.excludes.map(&:criteria)
		@location = @request.locations
		@request.jobs.delete_all

		scrape = RequestsHelper::Scraper.new(@request,@title)
		attribs = {:include => @include, :location => @location,:exclude => @exclude,:title => @title}
		scrape.process_request(attribs)

		@request.date_updated = Time.now.strftime("%d/%m/%Y")
		@request.save
	end



private

	def valid_include?
		!(params[:request][:includes][:include].empty?) && !(@request.includes.find_by criteria: params[:request][:includes][:include])
	end

	def valid_exclude?
		!(params[:request][:excludes][:exclude].empty?) && !(@request.excludes.find_by criteria: params[:request][:excludes][:exclude])
	end

	def request_params
		params.require(:request).permit(:job_titles, :id)
	end

	def save_job_titles
		@request.job_title = JobTitlesSelection.find(params[:request][:job_titles][:selected_job_titles]).title_select unless params[:request][:job_titles][:selected_job_titles].empty?
		@request.save
	end

	def valid_parameters?
		!@request.includes.empty? || !@request.excludes.empty?
	end

end
