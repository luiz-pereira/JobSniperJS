class Addrequestidtojtselections < ActiveRecord::Migration[6.0]
	def change
		add_column :job_titles_selections, :request_id, :integer
	end
end
