class AgeGroup < ApplicationRecord
  belongs_to :ct_user

  	def self.age_data(params)

  	  i=0

  	  ct_user = CtUser.find_or_create_by(id: params[:ct_user_id])
  	  

  	  client = SODA::Client.new({:domain => "https://data.ct.gov/resource/ypz6-8qyf.json"})

      data = client.get("https://data.ct.gov/resource/ypz6-8qyf.json", "$where" => "dateupdated between'#{params[:start_date]}' and '#{params[:end_date]}'")

      while i < data.body.count
      	age_group = AgeGroup.new
        age_group.query_date = data.body[i].dateupdated
        age_group.age_group = data.body[i].agegroups
        age_group.total_cases = data.body[i].totalcases
        age_group.total_case_rate = data.body[i].totalcaserate
        age_group.total_deaths = data.body[i].totaldeaths
        ct_user.age_groups << age_group
        i+=1
      end 
  	end

end
