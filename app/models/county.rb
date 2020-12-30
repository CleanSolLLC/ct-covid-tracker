class County < ApplicationRecord
  belongs_to :user
  has_many :towns



  def self.county_data(params, user)

      if Date.parse(params[:start_date]).sunday?
        start_date = (Date.parse(params[:start_date]).prev_day-2).to_s
      else
        start_date = (Date.parse(params[:start_date]).prev_day).to_s
      end

      end_date = params[:end_date]

  	  i=0  	  

  	  client = SODA::Client.new({:domain => "https://data.ct.gov/resource/bfnu-rgqt.json"})

      data = client.get("https://data.ct.gov/resource/bfnu-rgqt.json", "$where" => "dateupdated between'#{params[:start_date]}' and '#{params[:end_date]}'")

      binding.pry

      #will use active record query similar to 
      # TownLookup.all.select { |m| m.county_lookup_id == 1 }
      # this will return an array of all of the towns associated with a particular county

      # while i < data.body.count

      #   county = County.find_or_create_by(user_id: user.id, query_date: data.body[i].dateupdated, name: data.body[i].county) 
      #   county.query_date = data.body[i].dateupdated
      #   county.name = data.body[i].county
      #   gender_case.confirmed_cases = data.body[i].confirmedcases
      #   gender_case.hospitalizations = data.body[i].hospitalization        
      #   gender_case.confirmed_deaths = data.body[i].confirmeddeaths

      #   #make a call to towns conreoller then to model to query data for the repective towns that belong to thatcounty 

      #   user.counties << county
       
      #   i+=1
      # end 
  end


end

