class EthnicCase < ApplicationRecord

  extend ActiveHash::Associations::ActiveRecordExtensions
  
  belongs_to :user


  def self.ethnic_data(params, user)

    if Date.parse(params[:start_date]).sunday?
      prev_date = (Date.parse(params[:start_date]).prev_day-2).to_s
    else
      prev_date = (Date.parse(params[:start_date]).prev_day).to_s
    end

    end_date = params[:end_date]


    #array formatting to pass values from params multi-select menu

    

    array = params[:ethnic_case_lookup_id].values.first.reject{|t| t == ""}


    array_to_s = array.map { |s| "'#{s}'" }.join(', ')     

  	
  	client = SODA::Client.new({:domain => "https://data.ct.gov/resource/7rne-efic.json"})

    data = client.get("https://data.ct.gov/resource/7rne-efic.json", "$where" => "hisp_race in (#{array_to_s}) and dateupdated between '#{prev_date}' and '#{end_date}'")
  
    #data = client.get("https://data.ct.gov/resource/7rne-efic.json", "$where" => "dateupdated between '#{prev_date}' and '#{end_date}'")

     

     sorted_data = data.body.sort_by{|hsh| hsh[:hisp_race]}

      # #while i < sorted_data.count

     sorted_data.each_index do |i|

       return if sorted_data[i+1].nil? 

        #trying to create a switch here to exit if there is no data beyond sorted_data[i+1].nil? however we need to enter this loop at least once if there is only one date

        #if one date is entered for start and end date we still return at least 2 values in the hash sorted_data[0] returns the previous dates values to determine if there has been an increase or decrease in values from the previous day. 


        race = sorted_data[i].hisp_race if race != sorted_data[i].hisp_race

        #binding.pry

        ethnic_case = EthnicCase.find_or_initialize_by(user_id: user.id, query_date: "#{sorted_data[i+1].dateupdated}".to_date, ethnic_group: "#{race}")


          if ethnic_case.id.nil? && race == sorted_data[i+1].hisp_race

            ethnic_case.query_date = sorted_data[i+1].dateupdated
            ethnic_case.ethnic_group = sorted_data[i+1].hisp_race
            ethnic_case.total_pop = sorted_data[i+1].total_pop.to_i
            ethnic_case.case_tot = sorted_data[i+1].case_tot.to_i 
            ethnic_case.deaths = sorted_data[i+1].deaths.to_i 

            ethnic_case.case_change = (sorted_data[i+1].case_tot.to_i - sorted_data[i].case_tot.to_i).abs 
            (sorted_data[i+1].case_tot.to_i > sorted_data[i].case_tot.to_i) ? ethnic_case.case_dir = "+" : ethnic_case.case_dir = "-" unless ethnic_case.case_change == 0
            ethnic_case.death_change = (sorted_data[i+1].deaths.to_i - sorted_data[i].deaths.to_i).abs
            (sorted_data[i+1].deaths.to_i > sorted_data[i].deaths.to_i) ? ethnic_case.death_dir = "+" : ethnic_case.death_dir = "-" unless ethnic_case.death_change == 0
          
            user.ethnic_cases << ethnic_case

          end

        end
  end
end

