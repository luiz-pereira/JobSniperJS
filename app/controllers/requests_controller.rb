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
		@request = Request.find(params[:request][:request_id])
		@user = current_user
		case params[:commit]
		when "Delete Selected"
			@user.delete_job_title_selection(params[:request][:job_titles][:selected_job_titles].reject(&:empty?))
			render action: '/new'
		when "Add"
			if valid_job_title?
				add_job_title
			else
				flash.now.alert = "When adding, job title can't be blank or existing"
			end
			render action: '/new'
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
			if valid_job_titles? && valid_parameters?
				save_job_titles
				get_jobs(@request)
				redirect_to user_request_jobs_path(@user, @request)
			else
				if !valid_job_titles?
					flash.now.alert = "Please select at least one job title"
				else
					flash.now.alert = "Please include at least one critera ('include' or 'exclude')"
				end
				render action: '/new'
			end
		end
	end

	def get_jobs(request)
		@user = current_user
		@request = request
		@titles = @request.job_titles.map(&:job_title)
		@include = @request.includes.map(&:criteria)
		@exclude = @request.excludes.map(&:criteria)
		@location = @request.locations
		@titles.each do |title|
			scrape = RequestsHelper::Scraper.new(@request,title)
			attribs = {:include => @include, :location => @location,:exclude => @exclude,:title => title}
			scrape.process_request(attribs)
		end
		@request.date_updated = Time.now.strftime("%d/%m/%Y")
		@request.save
	end



private

	def add_job_title
		@user = current_user
		@user.job_titles_selections.create({title_select: params[:request][:job_titles][:title_select].split(' ').map(&:capitalize).join(' ').strip})
	end

	def valid_job_title?
		!(params[:request][:job_titles][:title_select].empty?) && !(@user.job_titles_selections.find_by title_select: (params[:request][:job_titles][:title_select].split(' ').map(&:capitalize).join(' ').strip))
	end

	def valid_include?
		!(params[:request][:includes][:include].empty?) && !(@request.includes.find_by criteria: params[:request][:includes][:include])
	end

	def valid_exclude?
		!(params[:request][:excludes][:exclude].empty?) && !(@request.excludes.find_by criteria: params[:request][:excludes][:exclude])
	end

	def request_params
		params.require(:request).permit(:job_titles, :id)
	end

	def valid_job_titles?
		!params[:request][:job_titles][:selected_job_titles].reject(&:empty?).empty?
	end

	def save_job_titles
		@request.job_titles.delete_all
		params[:request][:job_titles][:selected_job_titles].reject(&:empty?).each do |jt|
			@request.job_titles.create({job_title: JobTitlesSelection.find(jt)[:title_select]})
		end
	end

	def valid_parameters?
		!@request.includes.empty? || !@request.excludes.empty?
	end

end
