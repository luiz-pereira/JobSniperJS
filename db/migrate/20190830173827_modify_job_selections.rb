class ModifyJobSelections < ActiveRecord::Migration[5.2]
	def change
		remove_column :job_titles_selections, :user_id
  end
end
