class CreateJobTitlesSelections < ActiveRecord::Migration[5.2]
  def change
    create_table :job_titles_selections do |t|
			t.integer "user_id"
			t.string "title_select"
      t.timestamps
    end
  end
end
