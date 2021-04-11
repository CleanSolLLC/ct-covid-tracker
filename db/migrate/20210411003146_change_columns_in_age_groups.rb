class ChangeColumnsInAgeGroups < ActiveRecord::Migration[6.0]
  def change
  	change_table :age_groups do |t|
  	  t.remove :case_change
  	  t.remove :death_change
  	  t.integer :case_change
  	  t.integer :death_change
  	end
  end
end
