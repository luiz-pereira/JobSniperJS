class DropTableJobTitle < ActiveRecord::Migration[5.2]
	def change
		drop_table :job_titles
  end
end
