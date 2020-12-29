class CreateGenderCases < ActiveRecord::Migration[6.0]
  def change
    create_table :gender_cases do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :query_date
      t.string :gender
      t.integer :confirmed_cases
      t.integer :confirmed_deaths

      t.timestamps
    end
  end
end
