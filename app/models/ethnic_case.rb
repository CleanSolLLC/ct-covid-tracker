class EthnicCase < ApplicationRecord

  extend ActiveHash::Associations::ActiveRecordExtensions
  extend GetData

  belongs_to :user


  def self.ethnic_data(params, user)

    prev_date = get_prev_date(params[:start_date])
    end_date = params[:end_date]

    #array formatting to pass values from params multi-select menu    
    array = params[:ethnic_case_lookup_id].values.first.reject{|t| t == ""}

    array_to_s = array.map { |s| "'#{s}'" }.join(', ')     

  	
  	client = SODA::Client.new({:domain => "https://data.ct.gov/resource/7rne-efic.json"})

    data = client.get("https://data.ct.gov/resource/7rne-efic.json", "$where" => "hisp_race in (#{array_to_s}) and dateupdated between '#{prev_date}' and '#{end_date}'")  

    data_found = find_data(params[:start_date], data) 
    sorted_data = data_found.sort_by{|hsh| hsh[:hisp_race]}

    sorted_data.each_index do |i|

      return if sorted_data[i+1].nil? 
      
      race ||= sorted_data[i+1].hisp_race

      unless sorted_data[i+1].dateupdated == sorted_data.first.dateupdated
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
end

