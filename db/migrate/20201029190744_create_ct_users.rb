class CreateCtUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :ct_users do |t|
      t.string :username
      t.date :query_date

      t.timestamps
    end
  end
end