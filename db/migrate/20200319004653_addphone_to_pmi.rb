class AddphoneToPmi < ActiveRecord::Migration[6.0]
	def change
		add_column :pmi_emails, :phone, :string
  end
end
