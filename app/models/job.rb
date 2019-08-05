class Job < ApplicationRecord
	belongs_to :request, autosave: true
end
