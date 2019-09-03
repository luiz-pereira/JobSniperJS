class ModPmImails < ActiveRecord::Migration[5.2]
	def change
		remove_column :pmi_emails, :phone
    remove_column :pmi_emails, :twitter
    remove_column :pmi_emails, :instagram
    remove_column :pmi_emails, :facebook
    remove_column :pmi_emails, :youtube
    remove_column :pmi_emails, :linkedin
		remove_column :pmi_emails, :website

		add_column :pmi_emails, :credentials, :string
  end
end
