class CreateTableInclude < ActiveRecord::Migration[5.2]
  def change
		create_table :includes do |t|
			t.integer "request_id"
			t.string "criteria"
      t.timestamps
    end
  end
end
