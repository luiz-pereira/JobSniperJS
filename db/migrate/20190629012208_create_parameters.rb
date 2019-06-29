class CreateParameters < ActiveRecord::Migration[5.2]
  def change
    create_table :parameters do |t|
			t.integer "request_id"
			t.string "criteria"
			t.boolean "exclude"
      t.timestamps
    end
  end
end
