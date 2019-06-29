class CreateJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :jobs do |t|
			t.integer "request_id"
			t.datetime "date_posted"
			t.string "source"
			t.string "title"
			t.string "company"
			t.text "description"
			t.string "tipe"
			t.string "seniority"
			t.string "city"
			t.string "province"
			t.string "country"
			t.string "link"
			t.string "summary"
			t.string "criteria"
			t.boolean "relevant"
      t.timestamps
    end
  end
end
