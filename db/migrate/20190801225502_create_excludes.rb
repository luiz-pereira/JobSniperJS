class CreateExcludes < ActiveRecord::Migration[5.2]
  def change
    create_table :excludes do |t|

      t.timestamps
    end
  end
end
