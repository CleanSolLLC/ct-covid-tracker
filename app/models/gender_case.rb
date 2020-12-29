class GenderCase < ApplicationRecord
 
  belongs_to :user

  def self.gender_data(params, user)

      if Date.parse(params[:start_date]).sunday?
        start_date = (Date.parse(params[:start_date]).prev_day-2).to_s
      else
        start_date = (Date.parse(params[:start_date]).prev_day).to_s
      end

      end_date = params[:end_date]

  	  i=0  	  

  	  client = SODA::Client.new({:domain => "https://data.ct.gov/resource/qa53-fghg.json"})

      data = client.get("https://data.ct.gov/resource/qa53-fghg.json", "$where" => "dateupdated between'#{params[:start_date]}' and '#{params[:end_date]}'")


      while i < data.body.count

        gender_case = GenderCase.find_or_create_by(user_id: user.id, query_date: data.body[i].dateupdated, gender: data.body[i].gender) 
        gender_case.query_date = data.body[i].dateupdated
        gender_case.gender = data.body[i].gender
        gender_case.confirmed_cases = data.body[i].confirmedcases
        gender_case.confirmed_deaths = data.body[i].confirmeddeaths
        user.gender_cases << gender_case
       
        i+=1
      end 
  end

end
