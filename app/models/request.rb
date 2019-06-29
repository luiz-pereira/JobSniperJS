class Request < ApplicationRecord
	belongs_to :user
	has_many :jobs
	has_many :parameters, :dependent => :destroy
	has_many :job_titles, :dependent => :destroy
	has_many :locations, :dependent => :destroy
end
