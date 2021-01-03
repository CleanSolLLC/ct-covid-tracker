class EthnicCase < ApplicationRecord
  
  belongs_to :user


  def self.get_ethnic_data(params, user)

    if Date.parse(params[:start_date]).sunday?
      start_date = (Date.parse(params[:start_date]).prev_day-2).to_s
    else
      start_date = (Date.parse(params[:start_date]).prev_day).to_s
    end

    end_date = params[:end_date]

  	
  	client = SODA::Client.new({:domain => "https://data.ct.gov/resource/7rne-efic.json"})
  
     data = client.get("https://data.ct.gov/resource/7rne-efic.json", "$where" => "dateupdated between '#{start_date}' and '#{end_date}'")

   
    days = 0
    i = 0
    date = params[:start_date]

    while days <= (Date.parse(params[:end_date]) - Date.parse(params[:start_date])).to_i  

      ethnic_case = EthnicCase.find_or_initialize_by(user_id: user.id, query_date: data.body[i].dateupdated, ethnic_group: data.body[i].hisp_race) 

      if ethnic_case.id.nil? && !data.body[i].nil?

          ethnic_case.query_date = data.body[i].dateupdated
      	  ethnic_case.ethnic_group = data.body[i].hisp_race
          ethnic_case.total_pop = data.body[i].total_pop.to_i
          ethnic_case.case_tot = data.body[i].case_tot.to_i
      	  ethnic_case.case_age_adjusted = data.body[i].caseageadjusted.to_i
          ethnic_case.deaths = data.body[i].deaths.to_i
          ethnic_case.death_age_adjusted = data.body[i].deathageadjusted.to_i

          user.ethnic_cases << ethnic_case      
      end     
    
      date = (Date.parse(date) + 1).to_s
      days+=1
      i+=1
    end
  end
end

