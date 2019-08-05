module RequestsHelper

	def parameters_exclude(request)
		request.parameters.select{|a|a.exclude}
	end

	def parameters_include(request)
		request.parameters.reject{|a|a.exclude}
	end

	class Scraper
		attr_accessor :request_id, :criteria

		def	initialize (request, criteria)
			@request = request
			@criteria = criteria
		end

		def process_request (params)
			get_jobs (params)
			clean_jobs_by_title(@criteria)
			get_description(@criteria)
			clean_jobs_by_description(@criteria)
		end

		def get_jobs (params)
			params[:page] = "0"
			doc = Nokogiri::HTML(open(format_link(params)))
			pages = get_pages(doc)
			for i in 0...pages do
				page = i * 50
				params[:page] = page.to_s
				doc = Nokogiri::HTML(open(format_link(params)))
				get_data(doc)
			end
		end

		def format_link(params)
			"https://www.indeed.ca/jobs?as_and=#{params[:include].join('+')}&as_phr=#{params[:title].gsub(' ','+')}&as_any=&as_not=#{params[:exclude].join('+')}&as_ttl=&as_cmp=&jt=fulltime&st=&as_src=&salary=&radius=5&l=Toronto%2C+ON&fromage=any&limit=50&sort=date&psf=advsrch&filter=0&start=#{params[:page]}"
		end

		def get_data(doc)
			doc.search(".jobsearch-SerpJobCard").each do |job|
				attribs = {}
				attribs[:title] = job.css(".title").text.strip
				attribs[:company] = job.css(".company").text.strip
				attribs[:summary] = job.css(".summary").text.strip
				attribs[:link] = "https://ca.indeed.com/viewjob?jk=" + job['id'].split('_')[1]
				attribs[:request_id] = @request_id
				attribs[:source] = "indeed"
				attribs[:tipe] = "full-time"
				attribs[:city] = "Toronto"
				attribs[:province] = "Ontario"
				attribs[:country] = "Canada"
				attribs[:criteria] = @criteria
				@request.jobs.create(attribs)
			end
		end

		def get_pages(doc)
			(doc.search("#searchCount").text.strip.gsub("Page 1 of ","").gsub("jobs","").strip.to_i / 50.00001 + 1).to_i
		end

		def clean_jobs_by_title(criteria)
			@request.jobs.where("criteria=? AND title NOT LIKE ?", criteria, "%#{criteria}%").delete_all
		end

		def get_description(criteria)
			jobs = @request.jobs.where(criteria: criteria)
			jobs.each do |job|
				doc=Nokogiri::HTML(open(job.link))
				job.description = doc.search(".jobsearch-jobDescriptionText").text.strip
				job.save
			end
		end

		def clean_jobs_by_description(criteria)
			@request.includes.each do |parameter|
				@request.jobs.where("criteria=? AND description NOT LIKE ?", criteria, "%#{parameter.criteria}%").destroy_all
			end
			@request.excludes.each do |parameter|
				@request.jobs.where("criteria=? AND description LIKE ?", criteria, "%#{parameter.criteria}%").destroy_all
			end
		end

	end

end
