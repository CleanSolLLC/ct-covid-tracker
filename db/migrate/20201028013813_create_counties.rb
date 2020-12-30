class CreateCounties < ActiveRecord::Migration[6.0]
  def change
    create_table :counties do |t|
      t.belongs_to :user
      t.datetime :query_date
      t.string :name
      t.integer :cnty_cod
      t.integer :confirmed_cases
      t.integer :hospitalizations
      t.integer :confirmed_deaths            

      t.timestamps
    end
  end
end
