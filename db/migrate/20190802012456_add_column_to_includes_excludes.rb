class AddColumnToIncludesExcludes < ActiveRecord::Migration[5.2]
	def change
		add_column :includes, :request_id, :integer
		add_column :excludes, :request_id, :integer
  end
end
