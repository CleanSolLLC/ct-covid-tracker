class CreateCounties < ActiveRecord::Migration[6.0]
  def change
    create_table :counties do |t|
      t.date :query_date
      t.string :name

      t.timestamps
    end
  end
end
