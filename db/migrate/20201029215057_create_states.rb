class CreateStates < ActiveRecord::Migration[6.0]
  def change
    create_table :states do |t|
      t.date :query_date
      t.string :name

      t.timestamps
    end
  end
end
