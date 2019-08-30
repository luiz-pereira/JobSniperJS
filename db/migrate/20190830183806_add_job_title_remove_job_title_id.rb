class AddJobTitleRemoveJobTitleId < ActiveRecord::Migration[5.2]
	def change
		remove_column :requests, :job_title_id
		add_column :requests, :job_title, :string
  end
end
