class CreateStates < ActiveRecord::Migration[6.0]
  def change
    create_table :states do |t|
      t.datetime :query_date
      t.string :name
      t.integer :total_tests
      t.integer :total_cases
      t.integer :confirmed_cases 
      t.integer :hospitalized_cases
      t.integer :confirmed_deaths

      t.timestamps
    end
  end
end
