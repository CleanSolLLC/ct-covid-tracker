class CreateEthnicData < ActiveRecord::Migration[6.0]
  def change
    create_table :ethnic_data do |t|
      t.date :query_date
      t.integer :cases_hispanic
      t.integer :cases_NH_American_Indian_or_Alaskan_Native
      t.integer :cases_NH_Asian_or_Pacific_Islander
      t.integer :cases_NH_Black
      t.integer :cases_NH_Multracial
      t.integer :cases_NH_White
      t.integer :cases_NH_Other
      t.integer :cases_Unknown
      t.integer :deaths_hispanic
      t.integer :deaths_NH_American_Indian_or_Alaskan_Native
      t.integer :deaths_NH_Asian_or_Pacific_Islander
      t.integer :deaths_NH_Black
      t.integer :deaths_NH_Multracial
      t.integer :deaths_NH_White
      t.integer :deaths_NH_Other
      t.integer :deaths_Unknown

      t.timestamps
    end
  end
end
