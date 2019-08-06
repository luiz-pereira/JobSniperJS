class User < ApplicationRecord
	validates :email, uniqueness: true
	has_secure_password

	has_many :requests, :dependent => :destroy
	has_many :jobs, through: :requests
	has_many :job_titles_selections

	def delete_job_title_selection(title_array)
		title_array.each do |title|
			JobTitlesSelection.find(title).destroy
		end
	end

end
