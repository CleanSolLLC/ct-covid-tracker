require "active_support/concern"

module GetData
  extend ActiveSupport::Concern

  def get_prev_date(start_date)
    # data was origionally collected and posted Sunday through Thursday. However it seems like data is now being collected and posted Monday through Friday excluding holidays. The previous days data is needed to calculate the increase or decrease from the start date and each subsequent date through the end_date utilized data from the day before. If we use a prev_date that goes back 4 days prior to the start_date we are assured that we will capture the previous date.
    (Date.parse(start_date)-5).to_s
  end

  def find_data(start_date, data)
    prev_day_data = data.body.select{|d| d.dateupdated < start_date}.last
    data.body.select{|d| d.dateupdated >= prev_day_data.dateupdated} 
  end 

  def find_state_data(start_date, data)
    prev_day_data = data.body.select{|d| d.date < start_date}.last
    data.body.select{|d| d.date >= prev_day_data.date} 
  end 

  def find_town_data(start_date, data)
    prev_day_data = data.body.select{|d| d.lastupdatedate < start_date}.last
    data.body.select{|d| d.lastupdatedate >= prev_day_data.lastupdatedate} 
  end 



end