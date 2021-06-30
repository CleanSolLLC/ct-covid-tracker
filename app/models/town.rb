class Town < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  extend GetData

  belongs_to :user

  def self.town_data(params, user)

      prev_date = get_prev_date(params[:start_date])
      end_date = params[:end_date]

      #array formatting to pass values from params multi-select menu

      array = params[:town_lookup_id].values.first.reject{|t| t == ""}

      array_to_s = array.map { |s| "'#{s}'" }.join(', ')      
 

  	  client = SODA::Client.new({:domain => "https://data.ct.gov/resource/28fr-iqnx.json"})

    
      data = client.get("https://data.ct.gov/resource/28fr-iqnx.json", "$where" => "lastupdatedate between'#{prev_date}' and '#{end_date}' and town_no in (#{array_to_s})")
     
      data_found = find_town_data(params[:start_date], data) 
      sorted_data = data_found.sort_by{|hsh| hsh[:town_no]}

      sorted_data.each_index do |i|

        return if sorted_data[i+1].nil?

        town_code = sorted_data[i].town_no if town_code != sorted_data[i].town_no

        town = Town.find_or_initialize_by(user_id: user.id, query_date: "#{sorted_data[i+1].lastupdatedate}".to_date, town_cod: "#{town_code}".to_i)

          if town.id.nil? && town_code == sorted_data[i+1].town_no

            town.query_date = sorted_data[i+1].lastupdatedate 
            town.town_cod = sorted_data[i+1].town_no.to_i
            town.name = sorted_data[i+1].town
            town.total_tests = sorted_data[i+1].numberoftests.to_i
            town.confirmed_cases = sorted_data[i+1].townconfirmedcases.to_i
            town.confirmed_deaths = sorted_data[i+1].townconfirmeddeaths.to_i 

            town_code == sorted_data[i+1].town_no
            
            town.test_change = (sorted_data[i+1].numberoftests.to_i - sorted_data[i].numberoftests.to_i).abs
            (sorted_data[i+1].numberoftests.to_i > sorted_data[i].numberoftests.to_i) ? town.test_dir = "+" : town.test_dir = "-" unless town.test_change == 0
            
            town.case_change = (sorted_data[i+1].townconfirmedcases.to_i - sorted_data[i].townconfirmedcases.to_i).abs 
            (sorted_data[i+1].townconfirmedcases.to_i > sorted_data[i].townconfirmedcases.to_i) ? town.case_dir = "+" : town.case_dir = "-" unless town.case_change == 0

            town.death_change = (sorted_data[i+1].townconfirmeddeaths.to_i - sorted_data[i].townconfirmeddeaths.to_i).abs 
            (sorted_data[i+1].townconfirmeddeaths.to_i > sorted_data[i].townconfirmeddeaths.to_i) ? town.death_dir = "+" : town.death_dir = "-" unless town.death_change == 0
            
            user.towns << town

          end

        end
  	end
end

