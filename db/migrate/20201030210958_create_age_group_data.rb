class CreateAgeGroupData < ActiveRecord::Migration[6.0]
  def change
    create_table :age_group_data do |t|
      t.integer :query_date
      t.integer :cases_0_9
      t.integer :cases_10_19
      t.integer :cases_20_29
      t.integer :cases_30_39
      t.integer :cases_40_49
      t.integer :cases_50_59
      t.integer :cases_60_69
      t.integer :cases_70_79
      t.integer :cases_80_and_older
      t.integer :deaths_0_9
      t.integer :deaths_10_19
      t.integer :eaths_20_29
      t.integer :deaths_30_39
      t.integer :deaths_40_49
      t.integer :deaths_50_59
      t.integer :deaths_60_69
      t.integer :deaths_70_79
      t.integer :deaths_80_and_older

      t.timestamps
    end
  end
end
