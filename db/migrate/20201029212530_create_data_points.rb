class CreateDataPoints < ActiveRecord::Migration[6.0]
  def change
    create_table :data_points do |t|
      t.references :user, null: false, foreign_key: true
      t.references :covid_stat, null: false, foreign_key: true
      t.date :query_date

      t.timestamps
    end
  end
end
