class AgeGroup < ApplicationRecord
  belongs_to :user

  	def self.age_data(params, user)

      if Date.parse(params[:start_date]).sunday?
        start_date = (Date.parse(params[:start_date]).prev_day-2).to_s
      else
        start_date = (Date.parse(params[:start_date]).prev_day).to_s
      end

      end_date = params[:end_date]


  	  client = SODA::Client.new({:domain => "https://data.ct.gov/resource/ypz6-8qyf.json"})

      data = client.get("https://data.ct.gov/resource/ypz6-8qyf.json", "$where" => "dateupdated between'#{params[:start_date]}' and '#{params[:end_date]}'")

      days = 0
      i = 0      
      date = params[:start_date]

      while days <= (Date.parse(params[:end_date]) - Date.parse(params[:start_date])).to_i  
        
        age_group = AgeGroup.find_or_initialize_by(user_id: user.id, query_date: data.body[i].dateupdated, age_group: data.body[i].agegroups) 
       
        if age_group.id.nil? && !data.body[i].nil?
          age_group.query_date = data.body[i].dateupdated
          age_group.age_group = data.body[i].agegroups
          age_group.confirmed_cases = data.body[i].confirmedcases
          age_group.confirmed_deaths = data.body[i].confirmeddeaths
          user.age_groups << age_group
        end
       
        date = (Date.parse(date) + 1).to_s
        days+=1
        i+=1
      end
    end

end

