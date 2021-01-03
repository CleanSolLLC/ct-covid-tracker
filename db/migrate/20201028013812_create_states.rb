class CreateStates < ActiveRecord::Migration[6.0]
  def change
    create_table :states do |t|
      t.belongs_to :user
      t.datetime :query_date
      t.string :name
      t.integer :total_tests
      t.integer :total_cases
      t.integer :confirmed_cases 
      t.integer :hospitalized_cases
      t.integer :confirmed_deaths
      t.integer :test_change
      t.integer :case_change
      t.integer :hospitalized_change
      t.integer :death_change
      t.string :test_dir
      t.string :case_dir
      t.string :hosp_dir
      t.string :death_dir
      t.integer :cases_age0_9
      t.integer :cases_age10_19
      t.integer :cases_age20_29
      t.integer :cases_age30_39
      t.integer :cases_age40_49
      t.integer :cases_age50_59
      t.integer :cases_age60_69
      t.integer :cases_age70_79
      t.integer :cases_age80_older


      t.timestamps
    end
  end
end
