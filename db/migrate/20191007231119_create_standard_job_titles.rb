class CreateStandardJobTitles < ActiveRecord::Migration[6.0]
  def change
    create_table :standard_job_titles do |t|
			t.string :job_title
      t.timestamps
    end
  end
end
