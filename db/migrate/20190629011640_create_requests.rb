class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
			t.integer "user_id"
			t.datetime "date_updated"
			t.string "name"
      t.timestamps
    end
  end
end
