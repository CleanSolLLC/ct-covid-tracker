class AddColumnsToGenderCases < ActiveRecord::Migration[6.0]
  def change
    add_column :gender_cases, :case_change, :integer
    add_column :gender_cases, :death_change, :integer
    add_column :gender_cases, :case_dir, :string
    add_column :gender_cases, :death_dir, :string
  end
end
