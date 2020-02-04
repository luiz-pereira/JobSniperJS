class AddTempColumnToRequest < ActiveRecord::Migration[6.0]
	def change
		add_column :requests, :temporary, :boolean
  end
end
