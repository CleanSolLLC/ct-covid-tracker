class AddColumnsToTowns < ActiveRecord::Migration[6.0]
  def change
    add_column :towns, :town_cod, :integer
    add_column :towns, :total_tests, :integer
    add_column :towns, :confirmed_cases, :integer
    add_column :towns, :confirmed_deaths, :integer
    add_column :towns, :test_change, :integer
    add_column :towns, :case_change, :integer
    add_column :towns, :death_change, :integer
    add_column :towns, :test_dir, :string
    add_column :towns, :case_dir, :string
    add_column :towns, :death_dir, :string
  end
end
