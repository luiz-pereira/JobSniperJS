class AddColumnPmiEmails < ActiveRecord::Migration[5.2]
	def change
		add_column :pmi_emails, :website, :string
  end
end
