class AddColumnToTowns < ActiveRecord::Migration[6.0]
  def change
    add_reference :towns, :county, null: false, foreign_key: true
  end
end
