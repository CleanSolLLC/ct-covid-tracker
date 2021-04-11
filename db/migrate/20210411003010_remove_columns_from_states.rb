class RemoveColumnsFromStates < ActiveRecord::Migration[6.0]
  def change
  	change_table :states do |t|

  	  t.remove :cases_age0_9
      t.remove :cases_age10_19  
      t.remove :cases_age20_29
      t.remove :cases_age30_39
      t.remove :cases_age40_49
      t.remove :cases_age50_59
      t.remove :cases_age60_69
      t.remove :cases_age70_79
      t.remove :cases_age80_older
  end

  end
end


