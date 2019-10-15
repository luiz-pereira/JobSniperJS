class Removejobtitlefromrequest < ActiveRecord::Migration[6.0]
	def change
		remove_column :requests, :job_title
  end
end
