class AddColumnToDataPoints < ActiveRecord::Migration[6.0]
  def change
    add_reference :data_points, :covid_stat, null: false, foreign_key: true
  end
end
