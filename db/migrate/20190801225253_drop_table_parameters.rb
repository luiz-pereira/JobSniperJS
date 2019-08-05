class DropTableParameters < ActiveRecord::Migration[5.2]
	def change
		drop_table :parameters
  end
end
