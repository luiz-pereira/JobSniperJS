class CreatePmiEmails < ActiveRecord::Migration[5.2]
  def change
    create_table :pmi_emails do |t|
			t.string :email
			t.string :name
			t.string :position
			t.string :phone
			t.string :mobile
			t.string :twitter
			t.string :instagram
			t.string :facebook
			t.string :youtube
			t.string :linkedin
      t.timestamps
    end
  end
end
