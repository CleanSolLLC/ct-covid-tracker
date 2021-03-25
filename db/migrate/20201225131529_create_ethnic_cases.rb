class CreateEthnicCases < ActiveRecord::Migration[6.0]
  def change
    create_table :ethnic_cases do |t|
      t.belongs_to :user
      t.date :query_date
      t.string :ethnic_group
      t.integer :total_pop
      t.integer :case_tot  
      t.integer :case_age_adjusted         
      t.integer :deaths                 
      t.integer :death_age_adjusted
    
      t.timestamps
    end
  end
end

