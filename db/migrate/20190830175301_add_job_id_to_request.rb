class AddJobIdToRequest < ActiveRecord::Migration[5.2]
	def change
		add_column :requests, :job_title_id, :integer
  end
end
