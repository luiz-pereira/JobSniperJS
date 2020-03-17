class RequestService

	def get_jobs(request)
		@request = request
		@titles = @request.job_titles.map(&:job_title)
		@include = @request.includes.map(&:criteria)
		@exclude = @request.excludes.map(&:criteria)
		@locations = @request.locations.map(&:city)
		@request.jobs.delete_all

		@locations.each do |location|
			@titles.each do |title|
				scrape = ScrapeService.new(@request, title, location)
				attribs = {:include => @include, :location => location,:exclude => @exclude,:title => title}
				scrape.process_request(attribs)
			end
		end
		@request.date_updated = Time.now.strftime("%d/%m/%Y")
		@request.save
	end
end