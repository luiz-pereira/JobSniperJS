class RequestSerializer < ActiveModel::Serializer
	attributes :id, :date_updated
	has_many :job_titles
	has_many :includes
	has_many :excludes

	has_one :job_count

	def job_count
	 	object.jobs.size
	end

	def job_titles
		object.job_titles.map(&:job_title)
	end

	def excludes
		object.excludes.map(&:criteria)
	end

	def includes
		object.includes.map(&:criteria)
	end

end
