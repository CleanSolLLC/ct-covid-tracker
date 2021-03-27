class GenderCase < ApplicationRecord
 
  belongs_to :user

  def self.gender_data(params, user)

      if Date.parse(params[:start_date]).sunday?
        prev_date = (Date.parse(params[:start_date]).prev_day-2).to_s
      else
        prev_date = (Date.parse(params[:start_date]).prev_day).to_s
      end

      end_date = params[:end_date]

  	  client = SODA::Client.new({:domain => "https://data.ct.gov/resource/qa53-fghg.json"})

      data = client.get("https://data.ct.gov/resource/qa53-fghg.json", "$where" => "dateupdated between'#{prev_date}' and '#{end_date}'")

      binding.pry
      sorted_data = data.body.sort_by{|hsh| hsh[:gender]}

      #while i < sorted_data.count

      sorted_data.each_index do |i|

        #trying to create a switch here to exit if there is no data beyond sorted_data[i+1].nil? however we need to enter this loop at least once if there is only one date

        #if one date is entered for start and end date we still return at least 2 values in the hash sorted_data[0] returns the previous dates values to determine if there has been an increase or decrease in values from the previous day. 


        return if sorted_data[i+1].nil? 

        gender_type = sorted_data[i].gender if gender_type != sorted_data[i].gender

        #binding.pry

        gender_case = GenderCase.find_or_initialize_by(user_id: user.id, query_date: "#{sorted_data[i+1].dateupdated}".to_date, gender: "#{gender_type}")
        binding.pry


          if gender_case.id.nil? && gender_type == sorted_data[i+1].gender

            gender_case.query_date = sorted_data[i+1].dateupdated
            gender_case.gender = sorted_data[i+1].gender
            gender_case.confirmed_cases = sorted_data[i+1].confirmedcases.to_i
            gender_case.confirmed_deaths = sorted_data[i+1].confirmeddeaths.to_i 

            gender_type == sorted_data[i+1].gender
            gender_case.case_change = (sorted_data[i+1].confirmedcases.to_i - sorted_data[i].confirmedcases.to_i) 
            (sorted_data[i+1].confirmedcases.to_i > sorted_data[i].confirmedcases.to_i) ? gender_case.case_dir = "+" : gender_case.case_dir = "-"
            gender_case.death_change = (sorted_data[i+1].confirmeddeaths.to_i - sorted_data[i].confirmeddeaths.to_i)
            (sorted_data[i+1].confirmeddeaths.to_i > sorted_data[i].confirmeddeaths.to_i) ? gender_case.death_dir = "+" : gender_case.death_dir = "-"
          
            user.gender_cases << gender_case

          end

        end
    end

end
