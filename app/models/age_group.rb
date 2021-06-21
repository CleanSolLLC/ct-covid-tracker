class AgeGroup < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user

  	def self.age_group_data(params, user)
  
      if Date.parse(params[:start_date]).sunday?
        prev_date = (Date.parse(params[:start_date]).prev_day-2).to_s
      else
        prev_date = (Date.parse(params[:start_date]).prev_day).to_s
      end

      end_date = params[:end_date]


      #array formatting to pass values from params multi-select menu

    

      array = params[:age_group_lookup_id].values.first.reject{|t| t == ""}


      array_to_s = array.map { |s| "'#{s}'" }.join(', ') 


  	  client = SODA::Client.new({:domain => "https://data.ct.gov/resource/ypz6-8qyf.json"})


      data = client.get("https://data.ct.gov/resource/ypz6-8qyf.json", "$where" => "agegroups in (#{array_to_s}) and dateupdated between '#{prev_date}' and '#{end_date}'")
   
      sorted_data = data.body.sort_by{|hsh| hsh[:agegroups]}

      sorted_data.each_index do |i|

        #trying to create a switch here to exit if there is no data beyond sorted_data[i+1].nil? however we need to enter this loop at least once if there is only one date

        #if one date is entered for start and end date we still return at least 2 values in the hash sorted_data[0] returns the previous dates values to determine if there has been an increase or decrease in values from the previous day. 


        return if sorted_data[i+1].nil? 

        age_range = sorted_data[i].agegroups if age_range != sorted_data[i].agegroups


        age_group = AgeGroup.find_or_initialize_by(user_id: user.id, query_date: "#{sorted_data[i+1].dateupdated}".to_date, age_group: "#{age_range}")


          if age_group.id.nil? && age_range == sorted_data[i+1].agegroups

            age_group.query_date = sorted_data[i+1].dateupdated
            age_group.age_group = sorted_data[i+1].agegroups
            age_group.confirmed_cases = sorted_data[i+1].confirmedcases.to_i
            age_group.confirmed_deaths = sorted_data[i+1].confirmeddeaths.to_i 

            age_group == sorted_data[i+1].agegroups
            age_group.case_change = (sorted_data[i+1].confirmedcases.to_i - sorted_data[i].confirmedcases.to_i).abs 
            (sorted_data[i+1].confirmedcases.to_i > sorted_data[i].confirmedcases.to_i) ? age_group.case_dir = "+" : age_group.case_dir = "-" unless age_group.case_change == 0
            age_group.death_change = (sorted_data[i+1].confirmeddeaths.to_i - sorted_data[i].confirmeddeaths.to_i).abs
            sorted_data[i+1].confirmeddeaths.to_i > sorted_data[i].confirmeddeaths.to_i ? age_group.death_dir = "+" : age_group.death_dir = "-" unless age_group.death_change == 0
          
            user.age_groups << age_group

          end

        end
    end

end

