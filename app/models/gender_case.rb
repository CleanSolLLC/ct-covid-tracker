class GenderCase < ApplicationRecord
  extend GetData
 
  belongs_to :user

  def self.gender_case_data(params, user)


    prev_date = get_prev_date(params[:start_date])
    end_date = params[:end_date]

  	client = SODA::Client.new({:domain => "https://data.ct.gov/resource/qa53-fghg.json"})

    data = client.get("https://data.ct.gov/resource/qa53-fghg.json", "$where" => "dateupdated between'#{prev_date}' and '#{end_date}'")

    data_found = find_data(params[:start_date], data) 
    sorted_data = data_found.sort_by{|hsh| hsh[:gender]}

    sorted_data.each_index do |i|

      return if sorted_data[i+1].nil? 

        gender_type ||= sorted_data[i].gender

        #binding.pry

        gender_case = GenderCase.find_or_initialize_by(user_id: user.id, query_date: "#{sorted_data[i+1].dateupdated}".to_date, gender: "#{gender_type}")


          if gender_case.id.nil? && gender_type == sorted_data[i+1].gender

            gender_case.query_date = sorted_data[i+1].dateupdated
            gender_case.gender = sorted_data[i+1].gender
            gender_case.confirmed_cases = sorted_data[i+1].confirmedcases.to_i
            gender_case.confirmed_deaths = sorted_data[i+1].confirmeddeaths.to_i 

            gender_type == sorted_data[i+1].gender
            gender_case.case_change = (sorted_data[i+1].confirmedcases.to_i - sorted_data[i].confirmedcases.to_i).abs 
            (sorted_data[i+1].confirmedcases.to_i > sorted_data[i].confirmedcases.to_i) ? gender_case.case_dir = "+" : gender_case.case_dir = "-" unless gender_case.case_change == 0
            gender_case.death_change = (sorted_data[i+1].confirmeddeaths.to_i - sorted_data[i].confirmeddeaths.to_i).abs
            (sorted_data[i+1].confirmeddeaths.to_i > sorted_data[i].confirmeddeaths.to_i) ? gender_case.death_dir = "+" : gender_case.death_dir = "-" unless gender_case.death_change == 0
          
            user.gender_cases << gender_case

          end

        end
    end

end
