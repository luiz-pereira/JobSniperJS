class Createjobtitleagain < ActiveRecord::Migration[6.0]
	def change
		create_table :job_titles do |t|
			t.string :job_title
			t.integer :request_id
			t.timestamps
		end
  end
end
