class User < ApplicationRecord
	validates :email, uniqueness: true
	validates :name, presence: true
	has_secure_password

	has_many :requests, :dependent => :destroy
	has_many :jobs, through: :requests

	def delete_job_title_selection(title_array)
		title_array.each do |title|
			JobTitlesSelection.find(title).destroy
		end
	end

	def create_username
		i = 0
		self.name.include?(' ') ? (username = self.name.split(' ').map(&:downcase).join('')) : (username = self.name.downcase)
		while User.find_by username: username
			i +=1
			username = username + i.to_s
		end
		username
	end

	def to_param
		username
	end

	def self.find_or_create_user_linkedin(auth)
		email = auth[:info][:email]
		@user = self.find_or_create_by(email: email) do |user|
			user.email = auth[:info][:email]
			user.name = auth[:info][:first_name] + ' ' + auth[:info][:last_name]
			user.name = user.name.gsub(/,.*/,'')
			user.username = user.create_username
			user.password = 'not needed'
			user.linkedin = true
		end
		@user.save
		@user
	end

end
