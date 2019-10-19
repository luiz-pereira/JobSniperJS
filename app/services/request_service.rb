class RequestService

	def get_jobs(request)
		@request = request
		@titles = @request.job_titles.map(&:job_title)
		@include = @request.includes.map(&:criteria)
		@exclude = @request.excludes.map(&:criteria)
		@location = @request.locations
		@request.jobs.delete_all

		@titles.each do |title|
			scrape = ScrapeService.new(@request,title)
			attribs = {:include => @include, :location => @location,:exclude => @exclude,:title => title}
			scrape.process_request(attribs)
		end
		@request.date_updated = Time.now.strftime("%d/%m/%Y")
		@request.save
	end
end