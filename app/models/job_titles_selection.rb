class JobTitlesSelection < ApplicationRecord
	validates :title_select, uniqueness: true

end
