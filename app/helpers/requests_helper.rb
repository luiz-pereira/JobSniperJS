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
			get_jobs_indeed(params) #indeed
			get_jobs_td(params) #TD
		end

		def get_jobs_indeed (params)
			params[:page] = "0"
			doc = Nokogiri::HTML(open(format_link_indeed(params)))
			pages = get_pages_indeed(doc)
			for i in 0...pages do
				page = i * 50
				params[:page] = page.to_s
				doc = Nokogiri::HTML(open(format_link_indeed(params)))
				get_data_indeed(doc)
			end
		end

		def get_jobs_td (attribs)
			attribs[:page] = "0"
			doc = Nokogiri::HTML(open(format_link_td(attribs)))
			get_data_td(doc)
		end

		def format_link_indeed(params)
			if params[:title] == ""
				"https://www.indeed.ca/jobs?as_and=#{params[:include].join('+')}&as_any=&as_not=#{params[:exclude].join('+')}&as_ttl=&as_cmp=&jt=fulltime&st=&as_src=&salary=&radius=5&l=Toronto%2C+ON&fromage=any&limit=50&sort=date&psf=advsrch&filter=0&start=#{params[:page]}"
			else
				"https://www.indeed.ca/jobs?as_and=#{params[:include].join('+')}&as_phr=#{params[:title].gsub(' ','+')}&as_any=&as_not=#{params[:exclude].join('+')}&as_ttl=&as_cmp=&jt=fulltime&st=&as_src=&salary=&radius=5&l=Toronto%2C+ON&fromage=any&limit=50&sort=date&psf=advsrch&filter=0&start=#{params[:page]}"
			end
		end

		def format_link_td(params)
			if params[:title] == ""
				"https://www.linkedin.com/jobs/search?keywords=location=Toronto%2C%20Ontario%2C%20Canada&trk=guest_job_search_jobs-search-bar_search-submit&redirect=false&position=1&pageNum=0&f_C=2775"
			else
				"https://www.linkedin.com/jobs/search?keywords=#{params[:title]}&location=Toronto%2C%20Ontario%2C%20Canada&trk=guest_job_search_jobs-search-bar_search-submit&redirect=false&position=1&pageNum=0&f_C=2775"
			end
		end

		def get_data_indeed(doc)
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

		def get_data_td(doc)
			doc.search(".result-card__full-card-link").map.with_index do |job,i|
				attribs = {}
				attribs[:title] = job.text.strip
				attribs[:company] = "TD"
				attribs[:summary] = doc.search(".job-result-card__snippet")[i].text
				attribs[:link] = job['href']
				attribs[:request_id] = @request_id
				attribs[:source] = "td"
				attribs[:tipe] = "full-time"
				attribs[:city] = "Toronto"
				attribs[:province] = "Ontario"
				attribs[:country] = "Canada"
				attribs[:criteria] = @criteria
				@request.jobs.create(attribs)
			end
		end

		def get_pages_indeed(doc)
			(doc.search("#searchCount").text.strip.gsub("Page 1 of ","").gsub("jobs","").strip.to_i / 50.00001 + 1).to_i
		end

		def get_pages_td(doc)
			(doc.search("#live-results-counter").text.strip)
		end

		def clean_jobs_by_title(criteria)
			if !!criteria
				@request.jobs.where("criteria=? AND title NOT LIKE ?", criteria, "%#{criteria}%").delete_all
			end
		end

		def get_description(criteria)
			get_description_indeed(criteria)
			get_description_td(criteria)
		end

		def get_description_indeed(criteria)
			jobs = @request.jobs.where(criteria: criteria, source: 'indeed')
			jobs.each do |job|
				doc=Nokogiri::HTML(open(job.link))
				job.description = doc.search(".jobsearch-jobDescriptionText").text.strip
				job.save
			end
		end

		def get_description_td(criteria)
			jobs = @request.jobs.where(criteria: criteria, source: 'td')
			jobs.each do |job|
				doc=Nokogiri::HTML(open(job.link))
				job.description = doc.search("span").text.strip
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
