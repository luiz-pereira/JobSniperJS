class CreateJobTitles < ActiveRecord::Migration[5.2]
  def change
    create_table :job_titles do |t|
			t.string "job_title"
    	t.integer "request_id"
      t.timestamps
    end
  end
end
