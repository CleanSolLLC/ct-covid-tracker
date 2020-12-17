class AddColumnsToStates < ActiveRecord::Migration[6.0]
  def change
    add_column :states, :test_change, :integer
    add_column :states, :case_change, :integer
    add_column :states, :hospitalized_change, :integer
    add_column :states, :death_change, :integer
    add_column :states, :test_dir, :string
    add_column :states, :case_dir, :string
    add_column :states, :hosp_dir, :string
    add_column :states, :death_dir, :string
  end
end
