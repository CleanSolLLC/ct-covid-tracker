class CreateTests < ActiveRecord::Migration[6.0]
  def change
    create_table :tests do |t|
      t.references :state, null: false, foreign_key: true
      t.references :county, null: false, foreign_key: true
      t.references :town, null: false, foreign_key: true
      t.date :query_date
      t.integer :num_tests

      t.timestamps
    end
  end
end
