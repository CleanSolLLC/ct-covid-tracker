class AddColumnsToCounties < ActiveRecord::Migration[6.0]
  def change
    add_column :counties, :case_change, :integer
    add_column :counties, :hospitalized_change, :integer
    add_column :counties, :death_change, :integer
    add_column :counties, :case_dir, :string
    add_column :counties, :hosp_dir, :string
    add_column :counties, :death_dir, :string
  end
end
