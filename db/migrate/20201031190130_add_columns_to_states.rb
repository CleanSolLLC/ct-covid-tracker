class AddColumnsToStates < ActiveRecord::Migration[6.0]
  def change
    add_column :states, :total_tests, :integer
    add_column :states, :total_cases, :integer
    add_column :states, :confirmed_cases, :integer
    add_column :states, :hospitalized_cases, :integer
    add_column :states, :confirmed_deaths, :integer
    add_column :states, :cases_age_0_9, :integer
    add_column :states, :cases_age_10_19, :integer
    add_column :states, :cases_age_20_29, :integer
    add_column :states, :cases_age_30_39, :integer
    add_column :states, :cases_age_40_49, :integer
    add_column :states, :cases_age_50_59, :integer
    add_column :states, :cases_age_60_69, :integer
    add_column :states, :cases_age_70_79, :integer
    add_column :states, :cases_age_80_older, :integer
  end
end
