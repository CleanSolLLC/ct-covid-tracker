class CreateGenderCases < ActiveRecord::Migration[6.0]
  def change
    create_table :gender_cases do |t|
      t.references :state, null: false, foreign_key: true
      t.references :gender_data, null: false, foreign_key: true

      t.timestamps
    end
  end
end
