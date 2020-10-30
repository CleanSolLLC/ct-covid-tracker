class CreateAgeGroupCases < ActiveRecord::Migration[6.0]
  def change
    create_table :age_group_cases do |t|
      t.references :state, null: false, foreign_key: true
      t.references :age_group_data, null: false, foreign_key: true

      t.timestamps
    end
  end
end
