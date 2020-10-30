class CreateCovidStats < ActiveRecord::Migration[6.0]
  def change
    create_table :covid_stats do |t|
      t.references :data_point, null: false, foreign_key: true
      t.references :state, null: false, foreign_key: true
      t.references :county, null: false, foreign_key: true
      t.references :town, null: false, foreign_key: true
      t.date :query_date

      t.timestamps
    end
  end
end
