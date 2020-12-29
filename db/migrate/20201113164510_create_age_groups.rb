class CreateAgeGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :age_groups do |t|
    	t.belongs_to :user
      t.datetime :query_date
      t.string :age_group 
      t.integer :confirmed_cases
      t.integer :confirmed_deaths   	

      t.timestamps
    end
  end
end
