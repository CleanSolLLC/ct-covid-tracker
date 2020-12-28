class AgeGroup < ApplicationRecord
  belongs_to :user

  	def self.age_data(params, user)

      if Date.parse(params[:start_date]).sunday?
        start_date = (Date.parse(params[:start_date]).prev_day-2).to_s
      else
        start_date = (Date.parse(params[:start_date]).prev_day).to_s
      end

      end_date = params[:end_date]

  	  i=0  	  

  	  client = SODA::Client.new({:domain => "https://data.ct.gov/resource/ypz6-8qyf.json"})

      data = client.get("https://data.ct.gov/resource/ypz6-8qyf.json", "$where" => "dateupdated between'#{params[:start_date]}' and '#{params[:end_date]}'")

      while i < data.body.count

        age_group = AgeGroup.find_or_create_by(user_id: user.id, query_date: data.body[i].dateupdated, age_group: data.body[i].agegroups) 
        age_group.query_date = data.body[i].dateupdated
        age_group.age_group = data.body[i].agegroups
        age_group.total_cases = data.body[i].totalcases
        age_group.total_deaths = data.body[i].totaldeaths
        user.age_groups << age_group
       
        i+=1
      end 
  	end

end

