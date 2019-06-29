class User < ApplicationRecord
	has_secure_password

	has_many :requests, :dependent => :destroy
	has_many :jobs, through: :requests
	has_many :job_title_selections
end
