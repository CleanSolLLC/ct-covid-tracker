class CreateGenderData < ActiveRecord::Migration[6.0]
  def change
    create_table :gender_data do |t|
      t.date :query_date
      t.integer :male_cases
      t.integer :female_cases
      t.integer :male_deaths
      t.integer :female_deaths

      t.timestamps
    end
  end
end
