class CreateAgeGroupCases < ActiveRecord::Migration[6.0]
  def change
    create_table :age_group_cases do |t|
    	
      t.references :state, null: false, foreign_key: true
      t.datetime :query_date
      t.string :age_group 
      t.integer :total_cases
      t.integer :total_case_rate
      t.integer :total_deaths   	

      t.timestamps
    end
  end
end
