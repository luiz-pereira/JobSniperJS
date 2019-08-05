class CreateTableExclude < ActiveRecord::Migration[5.2]
  def change
		create_table :excludes do |t|
			t.integer "request_id"
			t.string "criteria"
      t.timestamps
    end
  end
end
