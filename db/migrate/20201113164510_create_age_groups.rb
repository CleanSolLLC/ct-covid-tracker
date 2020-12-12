class CreateAgeGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :age_groups do |t|
    	t.belongs_to :user
      t.datetime :query_date
      t.string :age_group 
      t.integer :total_cases
      t.integer :total_case_rate
      t.integer :total_deaths   	

      t.timestamps
    end
  end
end
