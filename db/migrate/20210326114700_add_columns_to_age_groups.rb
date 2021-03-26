class AddColumnsToAgeGroups < ActiveRecord::Migration[6.0]
  def change
    add_column :age_groups, :case_change, :string
    add_column :age_groups, :death_change, :string
    add_column :age_groups, :case_dir, :string
    add_column :age_groups, :death_dir, :string
  end
end
