class AddColumn < ActiveRecord::Migration[5.2]
	def change
		add_column :includes, :criteria, :string
		add_column :excludes, :criteria, :string
  end
end
