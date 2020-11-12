class CreateUserStates < ActiveRecord::Migration[6.0]
  def change
    create_table :user_states do |t|
      t.references :state, null: false, foreign_key: true
      t.references :ct_user, null: false, foreign_key: true
      t.date :query_date

      t.timestamps
    end
  end
end
