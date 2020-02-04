class Location < ApplicationRecord
	belongs_to :request, autosave: true
end
