class CreateStates < ActiveRecord::Migration[6.0]
  def change
    create_table :states do |t|
      t.date :query_date
      t.string :name
      t.integer :total_tests
      t.integer :total_cases
      t.integer :confirmed_cases 
      t.integer :hospitalized_cases
      t.integer :confirmed_deaths
      t.integer :cases_age_0_9
      t.integer :cases_age_10_19
      t.integer :cases_age_20_29
      t.integer :cases_age_30_39
      t.integer :cases_age_40_49
      t.integer :cases_age_50_59
      t.integer :cases_age_60_69
      t.integer :cases_age_70_79
      t.integer :cases_age_80_older

      t.timestamps
    end
  end
end
