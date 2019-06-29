class JobsController < ApplicationController
	get '/:username/requests/:request' do
		@user = current_user
		@reqest = Request.find_by id: params[:request]
		@titles = @reqest.job_titles.map(&:job_title)
		@include = @reqest.parameters.reject(&:exclude).map(&:criteria)
		@exclude = @reqest.parameters.select(&:exclude).map(&:criteria)
		@reqest.save
		erb :job
	end

	get '/:username/requests/:request/update' do
		@user = current_user
		@reqest = Request.find_by id: params[:request]
		@titles = @reqest.job_titles.map(&:job_title)
		@include = @reqest.parameters.reject(&:exclude).map(&:criteria)
		@exclude = @reqest.parameters.select(&:exclude).map(&:criteria)
		@location = @reqest.locations
			@titles.each do |title|
			scrape = Scraper.new(@reqest,title)
			attribs = {:include => @include, :location => @location,:exclude => @exclude,:title => title}
			scrape.process_request(attribs)
		end
		@reqest.date_updated = Time.now.strftime("%d/%m/%Y")
		@reqest.save
		redirect "/#{@user.username}/requests/#{@reqest.id}"
	end
end
