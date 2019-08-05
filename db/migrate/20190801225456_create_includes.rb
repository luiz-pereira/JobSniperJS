class CreateIncludes < ActiveRecord::Migration[5.2]
  def change
    create_table :includes do |t|

      t.timestamps
    end
  end
end
