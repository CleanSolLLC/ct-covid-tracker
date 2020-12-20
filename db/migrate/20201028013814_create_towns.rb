class CreateTowns < ActiveRecord::Migration[6.0]
  def change
    create_table :towns do |t|
      t.datetime :query_date
      t.string :name
      t.references :county, null: false, foreign_key: true

      t.timestamps
    end
  end
end
